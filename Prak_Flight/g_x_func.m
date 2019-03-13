function g_x = g_x_func (phi, h)
  a = 6378137;
  g_e = 9.78030;
  beta_1 = 5.302 * 1e-3;
  beta_2 = 7 * 1e-6;
  delta_g = 14 * 1e-5;
  
  g_comp = g_e * (1 + beta_1 * sin(phi)^2 ...
                  - beta_2 * sin(2 * phi)^2 - 2 * h / a) - delta_g;
  g_x = [0; 0; -g_comp];
end