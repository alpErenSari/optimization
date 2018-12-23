function [sol, i] = rank_1(f, g, x0, iterations, error)
    res = 0;
    x = x0;
    H0 = eye(length(x));
    x_old = x;
    fibo = fibonacci(50);
    H = H0;
    loss = [];
    
    for i = 1:iterations
        loss = [loss f(x)];
        d_k = -H*g(x);
        f_a = @(a) f(x + a.*d_k);
        alpha_max = a_max_calculate(f, d_k, x);
        [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
%        alpha = lagrange_search(f_a, 0, alpha_max);
%         [alpha, it] = threePointInterval(f_a, 0, alpha_max, 1e-4);
%         [alpha, it] = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
%         alpha = rand();
%        display("alpha is " + num2str(alpha));
        x = x + alpha*d_k;
        p_k = alpha*d_k;
        q_k = g(x) - g(x_old);
        H = H + (p_k - H*q_k)*(p_k - H*q_k)'/(q_k'*(p_k - H*q_k));
        if(norm(x - x_old) < error)
            res = 1;
            break;
        end
        x_old = x;
    end
    sol = x;
    i = i+1;
end