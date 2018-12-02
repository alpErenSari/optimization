function [x_sol,i, res] = parallel_tangents_new(f, f_grad, x0, i_max,error)
    x=x0;
    x_old=x;
    fibo=fibonacci(50);
    for i = 1:i_max
        x_memory=x;
        d=-f_grad(x);  
        f_a = @(a) f(x + a.*d);
        alpha_max = a_max_calculate(f, d, x);
        alpha = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
        x = x + alpha*d;
        d=-f_grad(x); 
        f_a = @(a) f(x + a.*d);
        alpha_max = a_max_calculate(f, d, x);
        alpha = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
        x = x + alpha*d;
        d=x-x_memory;
        f_a = @(a) f(x + a.*d);
        alpha_max = a_max_calculate(f, d, x);
        alpha = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
        x = x + alpha*d;
        if(norm(x - x_old) < error)
            res = 1;
%         break;
        end
        x_old=x;

    end
    x_sol = x;
end