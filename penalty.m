function [x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max)
    eps = 1e-6;
    H0 = eye(length(x0));
    h = constraints{1};
    h_grad = constraints{2};
    g = constraints{3};
    g_grad = constraints{4};
    unconstrained_solver = constraints{5};
    search = constraints{6};
%     keyboard
    J_aug = @(x) f(x) + M*h(x)'*h(x) + M*max(0,g(x))'*max(0,g(x));
%     J_aug_grad = @(x) f_grad(x) + 2*M*h_grad(x)*h(x) + 2*M*(max(0,g(x)) > 0).*(g_grad(x)*g(x));
    J_aug_grad = @(x) gradient_calculater(J_aug, x);
    J_aug_hess = @(x) hessian_calculate(J_aug, x);

    loop_step = 5;
    it = round(i_max/loop_step);
    
    for i = 1:it
%         keyboard;
        if(strcmp(unconstrained_solver,'fletcher_reeves'))
            [x_sol, k] = fletcher_reeves (J_aug, J_aug_grad, J_aug_hess, x0, search, loop_step);
        elseif(strcmp(unconstrained_solver, 'steepest_descent'))
            [x_sol, k, res] = steepest_descent(J_aug, J_aug_grad, J_aug_hess, x0, loop_step, search, eps);
         elseif(strcmp(unconstrained_solver, 'rank_2_correction'))   
            [x_sol, k] = rank_2(J_aug, J_aug_grad, J_aug_hess, x0, H0, loop_step, search, eps);
        elseif(strcmp(unconstrained_solver, 'newton_method'))   
            [x_sol, k, res] = newton(J_aug, J_aug_grad, J_aug_hess, x0, loop_step, search, eps);
        end
        
        M = M*1.2;
        x0 = x_sol;
        J_aug = @(x) f(x) + M*h(x)'*h(x) + M*max(0,g(x))'*max(0,g(x));
%         J_aug_grad = @(x) f_grad(x) + 2*M*h_grad(x)*h(x) + 2*M*(max(0,g(x)) > 0).*(g_grad(x)*g(x));
        J_aug_grad = @(x) gradient_calculater(J_aug, x);
        J_aug_hess = @(x) hessian_calculate(J_aug, x);
        
        if(norm(J_aug_grad(x_sol)) < eps)
            break;
        end
        
    end
%     i = (i-1)*20 + k;
end

 