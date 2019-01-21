function [x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max)
    eps = 0;
    H0 = eye(length(x0));
    h = constraints{1};
    h_grad = constraints{2};
    g = constraints{3};
    g_grad = constraints{4};
    unconstrained_solver = constraints{5};
    search = constraints{6};
    
    J_aug = @(x) f(x) - (1/M)*sum(1./(h(x)-eps)) - (1/M)*sum(1./(-h(x)-eps)) - (1/M)*sum(1./(g(x)-eps));
%     J_aug_grad = @(x) f_grad(x) + M*h_grad(x)*(1 ./(h(x)-eps)).^2 ...
%         - M*h_grad(x)*(1 ./(-h(x)-eps)).^2 + M*g_grad(x)*(1 ./(g(x)-eps)).^2;
    J_aug_grad = @(x) gradient_calculater(J_aug, x);
    J_aug_hess = @(x) hessian_calculate(J_aug, x);
    
%     keyboard;
    loop_step = 1;
    it = round(i_max/loop_step);
    
    for i = 1:it
        if(strcmp(unconstrained_solver,'fletcher_reeves'))
            [x_sol, k] = fletcher_reeves (J_aug, J_aug_grad, J_aug_hess, x0, search, loop_step);
        elseif(strcmp(unconstrained_solver, 'steepest_descent'))
            [x_sol, k, res] = steepest_descent(J_aug, J_aug_grad, J_aug_hess, x0, loop_step, search, eps);
         elseif(strcmp(unconstrained_solver, 'rank_2_correction'))   
            [x_sol, k] = rank_2(J_aug, J_aug_grad, J_aug_hess, x0, H0, loop_step, search, eps);
        elseif(strcmp(unconstrained_solver, 'newton_method'))   
            [x_sol, k, res] = newton(J_aug, J_aug_grad, J_aug_hess, x0, loop_step, search, eps);
        end
        M = M*1.02;
        x0 = x_sol;
        J_aug = @(x) f(x) - (1/M)*sum(1./(h(x)-eps)) - (1/M)*sum(1./(-h(x)-eps)) - (1/M)*sum(1./(g(x)-eps));
%         J_aug_grad = @(x) f_grad(x) + M*h_grad(x)*(1 ./(h(x)-eps)).^2 ...
%             - M*h_grad(x)*(1 ./(-h(x)-eps)).^2 + M*g_grad(x)*(1 ./(g(x)-eps)).^2;
        J_aug_grad = @(x) gradient_calculater(J_aug, x);
        J_aug_hess = @(x) hessian_calculate(J_aug, x);
        
        if(norm(J_aug_grad(x_sol)) < eps)
            break;
        end
        
    end
%     i = (i-1)*20 + k;
end
