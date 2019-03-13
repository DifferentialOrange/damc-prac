function [EV] = eig_val(K, C, R, p)
  %compute sorted eigen values
  eq_size = size(K)(1);
  A = [-K-p*R, -C; eye(eq_size), zeros(eq_size, eq_size)];
  EV = sort(eig(A));
end