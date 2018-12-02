function [sol, i, res] = parallel_tangents(f, g, x0, iterations, error)
    res = 0;
    x = x0;
    x_old = x;
    x_old_2 = x;
    fibo = fibonacci(50);
    loss = [];
    
    for i = 1:iterations
        loss = [loss f(x)];
        if(mod(i, 2) == 1) || (i < 3)
            S = -g(x);
        else
            S = x - x_old_2;
        end
        f_a = @(a) f(x + a.*S);
        alpha_max = a_max_calculate(f, S, x);
%         [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
%         alpha = lagrange_search(f_a, 0, alpha_max);
%         [alpha, it] = threePointInterval(f_a, 0, alpha_max, 1e-4);
        [alpha, it] = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
%         alpha = rand();
%        display(alpha);
         x = x + alpha*S;
       
        if(norm(x - x_old) < error)
            res = 1;
%             break;
        end
        x_old_2 = x_old;
        x_old = x;
    end
    sol = x;
    i = i+1;
end