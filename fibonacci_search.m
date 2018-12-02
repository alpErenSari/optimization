function [res, iteration] = fibonacci_search(f, a, b, fibo, tol)
    alpha = 2/(sqrt(5) + 1);
    n = length(fibo);

    lambda = a + fibo(n-2)/fibo(n)*(b - a);
    mu = a + fibo(n-1)/fibo(n)*(b - a);

    iteration = 0;
    while(abs(b - a) > tol) && (iteration < n-2)
        if(f(lambda) < f(mu))
            b = mu;
        else
            a = lambda;
        end

        lambda = a + fibo(n-2-iteration)/...
            fibo(n-iteration)*(b - a);
        mu = a + fibo(n-1-iteration)/...
            fibo(n-iteration)*(b - a);

        if(iteration == n-2)
            mu = mu + tol;
        end
            
        iteration = iteration + 1;

    end

    res = (a + b) / 2;

end

    