function [L, A_z, A_x] = L_matrix(V_x, phi, h, w_i, A_z_prev, A_x_prev, t_step)
  Earth_a = 6378137;
  Earth_e = 6.6943799901413 * 1e-3;
  Earth_u = 2 * pi * (1 + 1 / 365.25) / (24. * 60 * 60);
  
  R_e = Earth_a / sqrt(1 - Earth_e * Earth_e * sin(phi) * sin(phi));
  R_N = Earth_a * (1 - Earth_e * Earth_e) / ...
              (sqrt(1 - Earth_e * Earth_e * sin(phi) * sin(phi)))^3;
  
  u_x = [0, Earth_u * cos(phi), Earth_u * sin(phi)];
  Omega_x = [- V_x(2) / (R_N + h), V_x(1) / (R_N + h), ...
                        V_x(1) * tan(phi) / (R_N + h)];
                        
   A_z = integration_matrix(w_i, t_step) * A_z_prev;
   A_x = integration_matrix(u_x + Omega_x, t_step) * A_x_prev;
  
   L = A_z * A_x';
end