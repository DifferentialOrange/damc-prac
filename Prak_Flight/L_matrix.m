function [L, A_z, A_x] = L_matrix(V_x, phi, h, w_i, A_z_prev, A_x_prev, t_step)

  R_E = R_E_func(phi);
  R_N = R_N_func(phi);
  
  u_x = u_x_func(phi);
  Omega_x = Omega_x_func(V_x, phi, h);
                        
  A_z = integration_matrix(w_i, t_step) * A_z_prev;
  A_x = integration_matrix(u_x + Omega_x, t_step) * A_x_prev;
  
  L = A_z * A_x';
end