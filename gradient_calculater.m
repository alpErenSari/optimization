function grad = gradient_calculater(fun, x)
    eps = 1e-4;
    grad = [];
    for i = 1:length(x)
        grad = [grad; (fun(x(i)+eps)-fun(x(i)))/eps];
    end
end