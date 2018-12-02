function [res, iteration] = dichotomous_search(f, a, b, tol)
alpha = 0.5;
epsilon = 1e-8;

lambda = a + (1 - alpha)*(b - a) - epsilon ;
mu = a + alpha*(b - a) + epsilon;

iteration = 0;
while(abs(b - a) > tol)
    if(f(lambda) < f(mu))
        b = mu;
    else
        a = lambda;
    end
    
    lambda = a + (1 - alpha)*(b - a) - epsilon;
    mu = a + alpha*(b - a) + epsilon;
    
    iteration = iteration + 1;
    
end

res = (a + b) / 2;

end