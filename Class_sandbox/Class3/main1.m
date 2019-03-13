a = 0;
b = 4;
Nint = 7;
f = @(t, u) [u(2); -u(1)];
g = @(ya, yb) [ya(1)+1; yb(1)-1];
t = linspace(0, 4, Nint);
solinit.x = t;
solinit.y = [t/2-1; 0*t];
sol = bvp4c(f, g, solinit);
figure(1)
plot(sol.x, sol.y)