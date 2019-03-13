function [X, Y] = achr(r1, r2, Am, Bm, N)
  
  if nargin < 5
    N = 100;
  end
  
  A = linspace(0, Am, N);
  B = linspace(0, Bm, N);
  X = (r1 + r2) * cos(A);
  Y = (r1 + r2) * sin(A);
  
  X = [X, r1*cos(Am)+r2*cos(Am+B)];
  Y = [Y, r1*sin(Am)+r2*sin(Am+B)];
  
  At = [fliplr(A), -A];
  
  X = [X, r1*cos(At)+r2*cos(At+Bm)];
  Y = [Y, r1*sin(At)+r2*sin(At+Bm)];
  
  if Y(end) > 0
    Bs = Am + asin(r1 / r2 * sin(Am));
    B = fliplr(linspace(Bs, Bm, N));
    X = [X, r1*cos(-Am)+r2*cos(-Am+B)];
    Y = [Y, r1*sin(-Am)+r2*sin(-Am+B)];
  else
    ind = Y > 0;
    X = X(ind);
    Y = Y(ind);
  end
  
  X = [X, fliplr(X)];
  Y = [Y, -fliplr(Y)];
  
  plot(X, Y)
  
end