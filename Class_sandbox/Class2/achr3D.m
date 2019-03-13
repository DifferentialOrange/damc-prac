clear X Y Z

N = 100;

Am = pi / 4;
Bm = pi / 12;
Gm = pi / 6;
r1 = 5;
r2 = 1;

g = linspace(-Gm, Gm, N);

[Xt, Yt] = achr(r1, r2, Am, Bm);

for k=1:length(g)
  X(k, :) = Xt*cos(g(k));
  Y(k, :) = Yt;
  Z(k, :) = Xt*sin(g(k));
end

figure(2)
surf(X, Y, Z)