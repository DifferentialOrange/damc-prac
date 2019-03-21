function f = bodytr(t, x)
  global m c k g sgn v nu
  
  f(1, 1) = x(2);
  f(2, 1) = (-c*x(1)-k*x(2))/m-g*nu*sgn;
end