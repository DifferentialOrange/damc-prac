function L_zero = start_L_matrix (mean_vect)
  w_vect = mean_vect(2:4);
  f_vect = mean_vect(5:7);
  
  w_x_f = cross(w_vect, f_vect);
  f_x_w_x_f = cross(f_vect, w_x_f);
  
  L_zero(:, 1) = w_x_f' / norm(w_x_f); 
  L_zero(:, 2) = f_x_w_x_f' / norm(f_x_w_x_f); 
  L_zero(:, 3) = f_vect' / norm(f_vect);
end