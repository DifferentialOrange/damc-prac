function u_x = u_x_func (phi)
  u = 2 * pi * (1 + 1 / 365.25) / (24. * 60 * 60); %Earth angular velocity module
  
  u_x = [0, u * cos(phi), u * sin(phi)];
end