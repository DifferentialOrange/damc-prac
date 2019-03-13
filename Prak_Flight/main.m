num_table = load("imu.txt");
trj_table = load("trj.txt");

%degrees to radians
num_table(:, 2:4) = num_table(:, 2:4) / 180.0 * pi;
trj_table(:, 2:3) = trj_table(:, 2:3) / 180.0 * pi;
trj_table(:, 8:10) = trj_table(:, 8:10) / 180.0 * pi;

num_start = num_table(1:21081, :); %initial state
num_moving = num_table(21082:end, :); %moving state
t_step = num_table(2, 1) - num_table(1, 1);
N_iter = size(num_moving)(1); %iterations

%initial values
L_zero = start_L_matrix(num_start);
A_z_prev = L_zero;
A_x_prev = eye(3);

V_x = [0; 0; 0];
phi = trj_table(2, 1);
lambda = trj_table(3, 1);
h = trj_table(4, 1);

model_trj = zeros(N_iter + 1, 6);
model_trj(1, :) = [phi, lambda, h, V_x'];

for ind = 1:N_iter
  R_N = R_N_func(phi);
  R_E = R_E_func(phi);
  Omega_x_hat = hat_matr(Omega_x_func(V_x, phi, h));
  u_x_hat = hat_matr(u_x_func(phi));
  g_x = g_x_func(phi, h);
  
  [L, A_z_prev, A_x_prev] = L_matrix(V_x, phi, h, num_moving(ind, 2:4), 
                          A_z_prev, A_x_prev, t_step);
                          
  phi_new = phi + V_x(2) / (R_N + h) * t_step;
  lambda_new = lambda + V_x(1) / (R_E + h) / cos(phi) * t_step;
  h_new = h + V_x(3) * t_step;
  V_x_new = V_x + ((Omega_x_hat + 2 * u_x_hat) * V_x + ...
                   g_x + L' * num_moving(ind, 5:7)') * t_step;
            
  phi = phi_new;
  lambda = lambda_new;
  h = h_new;
  V_x = V_x_new;
  
  model_trj(ind + 1, :) = [phi, lambda, h, V_x'];
endfor

model_trj(end, :)
trj_table(end, :)