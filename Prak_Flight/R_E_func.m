function R_E = R_E_func (phi)
  a = 6378137;
  e = 6.6943799901413 * 1e-3;
  
  R_E = a / sqrt(1 - e^2 * sin(phi).^2);
end