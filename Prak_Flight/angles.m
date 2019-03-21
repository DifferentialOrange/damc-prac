function [psi, theta, gamma] = angles (L) 
  psi = atan2(L(1, 1), L(1, 2));
  theta = atan2(L(1, 3), sqrt(L(1, 1) ^ 2 + L(1, 2) ^ 2));
  gamma = atan2(-L(3, 3), L(2, 3));
end