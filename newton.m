function [sol, i, res] = newton(f, g, H, x0, iterations, search, error)
    res = 0;
    x = x0;
    x_old = x;
    if(strcmp(search, 'fibonacci'))
        fibo = fibonacci(50);
    end
    loss = [];
    
    for i = 1:iterations
        loss = [loss f(x)];
        delta_x = linsolve(H(x) + 0.01*randn(length(x),length(x)), -g(x));
        f_a = @(a) f(x + a.*delta_x);
        alpha_max = a_max_calculate(f, delta_x, x);
%         [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
%        alpha = lagrange_search(f_a, 0, alpha_max);
%         [alpha, it] = threePointInterval(f_a, 0, alpha_max, 1e-4);
%         [alpha, it] = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
        if(strcmp(search, 'lagrange'))
            alpha = lagrange_search(f_a, 0, alpha_max);
        elseif(strcmp(search, 'golden') )
            [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
        elseif(strcmp(search, 'fibonacci'))
            [alpha, it] = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
        elseif(strcmp(search, 'dichotomous'))
            [alpha, it] = dichotomous_search(f_a, 0, alpha_max, 1e-4);
        elseif(strcmp(search, 'three_point'))
            [alpha, it] = threePointInterval(f_a, 0, alpha_max, 1e-4);
        elseif(strcmp(search, 'newton_line'))
            g_a = @(a) delta_x'*g(x + a.*delta_x);
            H_a = @(a) delta_x'*H(x + a.*delta_x)*delta_x; 
            [alpha, it] = newton_line(f_a, g_a, H_a, 0, alpha_max, 1e-4);
        end
%         alpha = rand();
%        display("alpha is " + num2str(alpha));
        x = x + alpha*delta_x;
        if(norm(x - x_old) < error)
            res = 1;
            %break;
        end
        x_old = x;
    end
    sol = x;
    i = i+1;
end