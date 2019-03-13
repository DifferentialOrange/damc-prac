num_table = load("imu_num.txt");

%degrees to radians
num_table(:, 2:4) = num_table(:, 2:4) / 180.0 * pi;

num_start = num_table(1:21081, 2:end);
num_moving = num_table(21082:end, 2:end);

L_zero = start_orientation_matrix(num_start);

t_step = num_table(2, 1) - num_table(1, 1);

A_z_prev = L_zero;
A_x_prev = eye(3);

%test code
for ind = 1:size(num_moving)(1)
  %some random numbers
  V_x = [1.24, 5.1, 0.23];
  phi = 0.28;
  h = 234;
  
  [L, A_z_prev, A_x_prev] = L_matrix(V_x, phi, h, num_moving(ind, 1:3), 
                          A_z_prev, A_x_prev, t_step);
endfor

L