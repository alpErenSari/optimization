function [sol, i, res] = newton(f, g, H, x0, iterations, error)
    res = 0;
    x = x0;
    x_old = x;
    
    
    for i = 1:iterations
        delta_x = linsolve(H(x), -g(x));
        f_a = @(a) f(x + a.*delta_x)
        alpha_max = a_max_calculate(f, delta_x, x);
%         [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
        alpha = lagrange_search(f_a, 0, alpha_max);
%         alpha = rand();
        display("alpha is " + num2str(alpha));
        x = x + alpha*delta_x;
        if(norm(x - x_old) < error)
            res = 1;
            break;
        end
        x_old = x;
    end
    sol = x;
    i = i+1;
end