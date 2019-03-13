function R_N = R_N_func (phi)
  a = 6378137;
  e = 6.6943799901413 * 1e-3;
  
   R_N = a * (1 - e^2) / ((1 - e^2 * sin(phi)^2)^(3/2));
end