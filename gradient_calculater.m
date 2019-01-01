function grad = gradient_calculater(fun, x)
    eps = 1e-4;
    grad = [];
    eps_vec = zeros(length(x),1);
    for i = 1:length(x)
        eps_vec(i) = eps;
        if(i > 1)
            eps_vec(i-1) = 0;
        end
        grad = [grad; (fun(x+eps_vec)-fun(x))/eps];
%         keyboard;
    end
end