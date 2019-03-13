function f = vand(t, y)
  global a;
  f(1, 1) = y(2);
  f(2, 1) = -y(1) + a * y(2) * (1 - y(1)^2);
end