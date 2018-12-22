function [x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max)
    eps = 1e-6;
    h = constraints{1};
    h_grad = constraints{2};
    g = constraints{3};
    g_grad = constraints{4};
    
    J_aug = @(x) f(x) + M*h(x)'*h(x) + M*max(0,g(x))'*max(0,g(x));
    J_aug_grad = @(x) f_grad(x) + 2*M*h_grad(x)*h(x) + 2*(max(0,g(x)) > 0).*(g_grad(x)*g(x));
    
    it = round(i_max/20)
    
    for i = 1:it
        [x_sol, k] = fletcher_reeves (J_aug, J_aug_grad, x0, 20);
        M = M*1.2;
        x0 = x_sol;
        J_aug = @(x) f(x) + M*h(x)'*h(x) + M*max(0,g(x))'*max(0,g(x));
        J_aug_grad = @(x) f_grad(x) + 2*M*h_grad(x)*h(x) + 2*(max(0,g(x)) > 0).*(g_grad(x)*g(x));
        
        if(norm(J_aug_grad(x_sol)) < eps)
            break;
        end
        
    end
%     i = (i-1)*20 + k;
end

 