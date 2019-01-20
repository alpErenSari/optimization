function x_sol = simplex_phase_2(A, b, c)
    [m,n] = size(A);
    n = n-m;
    epsilon = 1e-8;
%     A_aug = [A eye(m)];
%     c_aug = [c zeros(1,m)];
    simp_aug = [A; c];
    simp_aug = [simp_aug [b 0]'];
    
    optimal = false;
    it = 0;
    while(~optimal)
      if(sum(simp_aug(m+1,:) < -epsilon) == 0)
        optimal = true;
        disp('Solution is optimal, stop');
        break;
      else
%           negative_places = (simp_aug(m+1,:) < 0);
          [~,pivot_col] = min(simp_aug(m+1,:));
          if(sum(simp_aug(1:m, pivot_col) > 0) == 0)
              disp('Problem is unbounded, exiting!');
              break;
          else
              row_test_array = (simp_aug(1:m, pivot_col) > 0) .*simp_aug(1:m, n+m+1);
              row_test_array = row_test_array ./ (simp_aug(1:m, pivot_col) + epsilon) ;
              row_test_array(row_test_array < epsilon) = 1e5;
              [low_ratio, pivot_row] = min(row_test_array);
              simp_aug(pivot_row, :) = simp_aug(pivot_row, :) ./ simp_aug(pivot_row, pivot_col);
              for i = 1:m+1
                  if(i ~= pivot_row)
                    simp_aug(i, :) = simp_aug(i, :) - simp_aug(i, pivot_col)*simp_aug(pivot_row, :);
                  end
              end
          end
      end
              
       display(it);
       display(rats(simp_aug));
       it = it + 1;
              
    end 
          
 
      
    x_sol = simp_aug;