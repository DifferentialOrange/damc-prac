global a;
a = 0.5;

opt = odeset('MaxStep', 0.2);
[T, Y] = ode45(@vand, [0, 100], [1, 0], opt);
plot(Y(:, 1), Y(:, 2))