c = 1;
k = 0.04;
m = 1;
nu = 0.5;
g = 9.8;
v = 4;
dt = 0.00001;
global m c k g sgn v nu

T0 = 0;
Tf = 100;
X0 = [-5, 11];
options = odeset("Events", @myevents, "MaxStep", 0.01);

figure(1)
cla
hold on
figure(2)
cla
hold on
sgn = sign(X0(2) - v);

warning('off', 'all');

while (T0 <= Tf)
  [T, Y, TE, YE, IE] = ode45(@bodytr, [T0, Tf], X0, options);
  figure(1)
  plot(T, Y)
  figure(2)
  plot(Y(:, 1), Y(:, 2))
  
  if (T(end) >= Tf) | (isempty(IE) == 1)
    break
  end
  
  T0 = T(end);
  X0 = Y(end, :)';

  q = c * X0(1) + k * X0(2);
  
  if abs(q) < nu * m * g
    Tr = (1.8 * nu * m * g / c - k * v / c - X0(1)) / v;
    if Tr > 0
      t = T0 + linspace(0, Tr);
      y = [X0(1) + v * (t - T0); v * ones(size(t))];
      figure(1)
      plot(t, y, '-')
      figure(2)
      plot(y(1, :), y(2, :), '-')
      
      T0 = t(end);
      X0 = y(:, end);
      
      sgn = sign(X0(2) - v);
    end
  end  
  
  X0 = X0 + dt * bodytr(T0, X0);
  T0 = T0 + dt;
end