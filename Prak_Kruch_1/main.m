K = 0.1 * [2, 1, 0; 1, 2, 1; 0, 1, 2];
C = [2, 1, 0; 1, 2, 1; 0, 1, 2];
R = [0, -1, 0; 1, 0, 1; 0, -1, 0];

eig_N = 2 * size(K)(1);
Eig_map = [];

for p = -10 : 0.05 : 10
  EV = eig_val(K, C, R, p);
  Eig_map = [Eig_map; real(EV), imag(EV), p*ones(eig_N, 1)];
end

clf reset;
hold on;
for ind = 1 : 1 : eig_N
  slice = ind : eig_N : size(Eig_map)(1);
  m_slice = Eig_map(slice, :);
  view(2);
  plot3(m_slice(:, 1), m_slice(:, 2), m_slice(:, 3));
  %plot(m_slice(:, 1), m_slice(:, 2));
end
hold off;