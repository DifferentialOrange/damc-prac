x = 0.1:0.1:3;

y = x;

[X, Y] = meshgrid(x, y);
Z = 1./(sin(0.3 * X.*Y) + 1);
plot3(X,Y,Z)
surfl(X, Y, Z, Sc)