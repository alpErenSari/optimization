function [x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max)
    eps = 1e-4;
    h = constraints{1};
    h_grad = constraints{2};
    g = constraints{3};
    g_grad = constraints{4};
    
    J_aug = @(x) f(x) - M*sum(1./(h(x)-eps)) - M*sum(1./(-h(x)-eps)) - M*sum(1./(g(x)-eps));
    J_aug_grad = @(x) f_grad(x) + M*h_grad(x)*(1 ./(h(x)-eps)).^2 ...
        - M*h_grad(x)*(1 ./(-h(x)-eps)).^2 + M*g_grad(x)*(1 ./(g(x)-eps)).^2;
    
    it = round(i_max/20);
    
    for i = 1:it
        [x_sol, k] = fletcher_reeves (J_aug, J_aug_grad, x0, 20);
        M = M/1.2;
        x0 = x_sol;
        J_aug = @(x) f(x) - M*sum(1./(h(x)-eps)) - M*sum(1./(-h(x)-eps)) - M*sum(1./(g(x)-eps));
        J_aug_grad = @(x) f_grad(x) + M*h_grad(x)*(1 ./(h(x)-eps)).^2 ...
            - M*h_grad(x)*(1 ./(-h(x)-eps)).^2 + M*g_grad(x)*(1 ./(g(x)-eps)).^2;
        
        if(norm(J_aug_grad(x_sol)) < eps)
            break;
        end
        
    end
%     i = (i-1)*20 + k;
end
