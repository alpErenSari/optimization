function hess = hessian_calculate(fun, x)
    eps = 1e-6;
    eps_vec = zeros(length(x), 1);
    hess = [];
    for i = 1:length(x)
        eps_vec(i) = eps;
        if(i > 1)
            eps_vec(i-1) = 0;
        end
        hess = [hess; ...
            (gradient_calculater(fun, x + eps_vec)-gradient_calculater(fun, x))'./eps];
    end
end