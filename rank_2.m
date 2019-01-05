function [sol, i] = rank_2(f, g, f_hess, x0, H0, iterations, search, error)
    res = 0;
    x = x0;
%     H0 = eye(length(x));
    x_old = x;
    if(strcmp(search, 'fibonacci'))
        fibo = fibonacci(50);
    end
    H = H0;
    loss = [];
    
    for i = 1:iterations
        loss = [loss f(x)];
        d_k = -H*g(x);
        f_a = @(a) f(x + a.*d_k);
        alpha_max = a_max_calculate(f, d_k, x);

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
            g_a = @(a) d_k'*g(x + a.*d_k);
            H_a = @(a) d_k'*f_hess(x + a.*d_k)*d_k; 
            [alpha, it] = newton_line(f_a, g_a, H_a, 0, alpha_max, 1e-4);
        end
%         alpha = rand();
%        display("alpha is " + num2str(alpha));
        x = x + alpha*d_k;
        p_k = alpha*d_k;
        q_k = g(x) - g(x_old);
        H = H + p_k*p_k'/(p_k'*q_k) - (H*q_k)*(H*q_k)'/(q_k'*H*q_k);
        if(norm(x - x_old) < error)
            res = 1;
            break;
        end
        x_old = x;
    end
    sol = x;
    i = i+1;
end