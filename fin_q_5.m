function [x_sol, i] = fin_q_5(f, g, H, c, A, x1, D1)
    eps = 1e-6;
    [m,n] = size(A);
    D = D1;
    x = x1;
    y = x;
    i = 0;
    k = 0;
    while(norm(g(y)) > eps)
        D_hat = D - D*A'*inv(A*D*A')*A*D;
        d = -D_hat*g(y);
        f_a = @(a) f(y + a.*d);
        alpha_max=a_max_calculate(f, d, y);
        alpha = lagrange_search(f_a, 0, alpha_max);
        y_old = y;
        y = y + alpha.*d;
        p = alpha.*d;
        q = g(y) - g(y_old);
        D = D + p*p'/(p'*q) - D*q*q'*D/(q'*D*q);
        i = i + 1;
        if(i == n)
            x = y;
            k = k + 1;
            if(k > n-m)
                break;
            end
            i = 0;
        end
       
        
        
            
    end
    x_sol = x;