function [val, ist, dir] = myevents(t, x)
  global m c k g sgn v nu
  
  val = x(2) - v;
  ist = 1;
  dir = 0;
end