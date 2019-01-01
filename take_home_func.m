function [x_sol, i] = take_home_func(N, M, method, solver, search, i_max)

    x = linspace(0,5,N);
    y0 = linspace(2,4,N);
    
    f = @(x) 2*pi*(5/N)*(sum(x) + 0.5*(2+x(1)) + 0.5*(x(end)+4));
    f_grad = @(x) gradient_calculater(f, x);
    if(strcmp(method, 'penalty'))
        h = @(x) 0;
    elseif(strcmp(method, 'barrier'))
        h = @(x) inf;
    end
    h_grad = @(x) 0;
    g = @(x) -x;
    g_grad = @(x) -eye(length(x));
    
%     unc_solver = 'fletcher_reeves';
    % unc_solver = 'steepest_descent';
    % unc_solver = 'rank_2_correction';
    % unc_solver = 'newton_method';
    
    x0 = y0(2:end-1)';
    constraints = {h, h_grad, g, g_grad, solver, search};
    
    tic
    if(strcmp(method, 'penalty'))
        [x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max);
    elseif(strcmp(method, 'barrier'))
        [x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max);
    end
    toc
    
    x_sol = [2; x_sol; 4];
    
end
