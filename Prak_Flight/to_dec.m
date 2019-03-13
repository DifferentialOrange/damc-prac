function [x, y, z] = to_dec(phi, lambda, h)
  R_E = R_E_func(phi);
  x = (R_E + h) .* cos(phi) .* cos(lambda);
  y = (R_E + h) .* cos(phi) .* sin(lambda);
  z = (R_E + h) .* sin(phi);
end