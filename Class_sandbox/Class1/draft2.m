t = 0:0.05:pi*2;

h1 = subplot(221);
plot(exp(-0.1 * t).*cos(t), exp(-0.1).*sin(t))

h2 = subplot(222); 
polar(t, exp(-0.1 * t))

h3 = subplot('position', [0.1, 0.1, 0.8, 0.4]);

