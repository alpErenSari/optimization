function [res, iteration] = golden_section(f, a, b, tol)
alpha = 2/(sqrt(5) + 1);

lambda = a + (1 - alpha)*(b - a);
mu = a + alpha*(b - a);

iteration = 0;
while(abs(b - a) > tol)
    if(f(lambda) < f(mu))
        b = mu;
    else
        a = lambda;
    end
    
    lambda = a + (1 - alpha)*(b - a);
    mu = a + alpha*(b - a);
    
    iteration = iteration + 1;
    
end

res = (a + b) / 2;

end


