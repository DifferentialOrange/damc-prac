a = 0;
b = 4;

f = @(t, u) [u(2); -u(1)];

[X, Y] = ode45(f, sol.x, [sol.y(1), sol.y(2)]);

max(abs(Y(1) - sol.y(1)));
max(abs(Y(2) - sol.y(2)));

clf reset;
hold on;

plot(X, abs(Y - sol.y')(:, 1), 'y')
plot(X, abs(Y - sol.y')(:, 2), 'r')
%legend('boundary', 'straight')
hold off;