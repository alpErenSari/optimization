function x_sol = my_simplex(c, A, b)
    [m,n] = size(A);
    epsilon = 1e-8;
    A_aug = [A eye(m)];
    c_aug = [c zeros(1,m)];
    simp_aug = [A_aug; c_aug];
    simp_aug = [simp_aug [b 0]'];
    
    optimal = false;
    while(~optimal)
      if(sum(simp_aug(m+1,:) < -epsilon) == 0)
        optimal = true;
        disp('Solution is optimal, stop');
      else
          negative_places = (simp_aug(m+1,:) < -epsilon);
          [~,pivot_col] = min(simp_aug(m+1,negative_places));
          if(sum(simp_aug(pivot_col, 1:m) > epsilon) == 0)
              disp('Problem is unbounded, exiting!');
              break;
          else
              row_test_array = (simp_aug(1:m, pivot_col) > epsilon) .*simp_aug(1:m, n+m+1);
              row_test_array = row_test_array ./ simp_aug(1:m, pivot_col);
              [~, pivot_row] = min(row_test_array(row_test_array > epsilon));
          
          
      end
      
    end
    x_sol = 5;
        
    
end