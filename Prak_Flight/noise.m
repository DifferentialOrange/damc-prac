num_table = load("imu.txt");
N = 21000;

num_table(:, 2:4) = num_table(:, 2:4) / 180.0 * pi; %degrees to radians
num_start = mean(num_table(1:N, :), 1); %initial state

num_start(2:7)
L_stable = start_L_matrix(num_start);

sigma_f = 0.03;
sigma_ang = 0.1 / 60 / 60 / 180.0 * pi; %radians per second

num_noise(:, 2:4) = num_table(1:N, 2:4) + randn(N, 3) * sigma_ang;
num_noise(:, 5:7) = num_table(1:N, 5:7) + randn(N, 3) * sigma_f;

num_noise_start = mean(num_noise(1:N, :), 1); %initial state
L_noise = start_L_matrix(num_noise_start);

[psi, theta, gamma] = angles(L_stable);
[psi_n, theta_n, gamma_n] = angles(L_noise);
psi_diff = abs(psi - psi_n)
theta_diff = abs(theta - theta_n)
gamma_diff = abs(gamma - gamma_n)