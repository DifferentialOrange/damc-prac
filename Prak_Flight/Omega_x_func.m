function Omega_x = Omega_x_func (V_x, phi, h)
  R_N = R_N_func(phi);
  R_E = R_E_func(phi);
  Omega_x = [-V_x(2)/(R_N + h), V_x(1)/(R_E + h), ...
                        V_x(1)*tan(phi)/(R_E + h)];
end