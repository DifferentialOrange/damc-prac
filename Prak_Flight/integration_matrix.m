function ans = integration_matrix (w_vec, t_step)
  EPS = 1e-9;
  
  w_matr = [        0,  w_vec(3), -w_vec(2);
            -w_vec(3),         0,  w_vec(1);
             w_vec(2), -w_vec(1),         0];
             
  norm_w = norm(w_vec);
  
  if norm_w * t_step < EPS
    turn1 = [ 1,                         0,                       0;
              0,    cos(w_vec(1) * t_step), -sin(w_vec(1) * t_step);
              0,    sin(w_vec(1) * t_step),  cos(w_vec(1) * t_step)];
              
    turn2 = [cos(w_vec(2) * t_step),    0,  -sin(w_vec(2) * t_step);
                                  0,    1,                        0;
             sin(w_vec(2) * t_step),    0,   cos(w_vec(2) * t_step)];
    
    turn3 = [cos(w_vec(3) * t_step), -sin(w_vec(1) * t_step),   0;
             sin(w_vec(3) * t_step),  cos(w_vec(3) * t_step),   0;
                                  0,                       0,   1];
                              
    ans = turn1 * turn2 * turn3;

  else
    ans = eye(3) + sin(norm_w * t_step) / norm_w * w_matr + ...
           + (1 - cos(norm_w * t_step)) / norm_w / norm_w * w_matr * w_matr;
  endif         
end