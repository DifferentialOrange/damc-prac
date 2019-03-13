num_table = load("imu.txt");
trj_table = load("trj.txt");

%degrees to radians
num_table(:, 2:4) = num_table(:, 2:4) / 180.0 * pi;
trj_table(:, 2:3) = trj_table(:, 2:3) / 180.0 * pi;
trj_table(:, 8:10) = trj_table(:, 8:10) / 180.0 * pi;

num_start = mean(num_table(1:21001, :), 1); %initial state
num_moving = num_table(21001:end, :); %moving state
trj_start = mean(trj_table(1:21001, :), 1); %initial state
trj_moving = trj_table(21001:end, 1:7); %moving state
t_step = num_table(2, 1) - num_table(1, 1);
N_iter = size(num_moving)(1); %iterations

%initial values
L = start_L_matrix(num_start);
A_z_prev = L;
A_x_prev = eye(3);

V_x = trj_start(5:7)';
phi = trj_start(2);
lambda = trj_start(3);
h = trj_start(4);

[start_dec(1, 1), start_dec(1, 2), start_dec(1, 3)] = to_dec(phi, lambda, h);

model_trj = zeros(N_iter + 1, 6);
model_trj(1, :) = [phi, lambda, h, V_x'];

for ind = 1:N_iter
  model_trj(ind, :) = [phi, lambda, h, V_x'];
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
  
  
endfor
model_trj(end, :) = [phi, lambda, h, V_x'];

last_model = model_trj(end, :)
last_traj = trj_table(end, 2:7)

norm(last_model - last_traj) / norm(last_traj)

for ind = 1:N_iter
  [model_trj_3d(ind, 1), model_trj_3d(ind, 2), model_trj_3d(ind, 3)]...
              = to_dec(model_trj(ind + 1, 1), model_trj(ind + 1, 2), ...
                                    model_trj(ind + 1, 3));
  [trj_3d(ind, 1), trj_3d(ind, 2), trj_3d(ind, 3)]...
              = to_dec(trj_moving(ind, 2), trj_moving(ind, 3), ...
                                    trj_moving(ind, 4));
                                    
  model_trj_3d(ind, :) = model_trj_3d(ind, :) - start_dec;
  trj_3d(ind, :) = trj_3d(ind, :) - start_dec;
  
  norm_plt(ind, 1) = norm(model_trj_3d(ind, :) - trj_3d(ind, :));
endfor

%figure(1);                            
%hold on;
%plot3(model_trj_3d(:, 1), model_trj_3d(:, 2), model_trj_3d(:, 3));
%plot3(trj_3d(:, 1), trj_3d(:, 2), trj_3d(:, 3));
%hold off;

norm(model_trj_3d(end, :) - trj_3d(end, :))

%figure(2);
%hold on;
%plot(trj_moving(:, 1), model_trj_3d(:, 1));
%plot(trj_moving(:, 1), trj_3d(:, 1));
%hold off;

hold on;
plot(trj_moving(:, 1), norm_plt(:, 1));
hold off;