function [x_sol, i, y0] = take_home_func(opt, i_max)

    M = opt.M;
    N = opt.N;
    x = linspace(0,5,N);
    if(opt.loop)
        y0 = opt.initial';
%         disp(size(y0));
    else
        initial_vec = vectorize(opt.initial);
        inital_func = inline(initial_vec);
        y0 = inital_func(x);
    end
    y0(1) = 2; y0(end) = 4;
%     y0 = linspace(2,4,N);
    
    f = @(x) 2*pi*(5/N)*(sum(x) + 0.5*(2+x(1)) + 0.5*(x(end)+4));
    f_grad = @(x) gradient_calculater(f, x);
    if(strcmp(opt.method, 'penalty'))
        h = @(x) 0;
    elseif(strcmp(opt.method, 'barrier'))
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
    constraints = {h, h_grad, g, g_grad, opt.solver, opt.search};
    
    
    if(strcmp(opt.method, 'penalty'))
        [x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max);
    elseif(strcmp(opt.method, 'barrier'))
        [x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max);
    end
    
    
    x_sol = [2; x_sol; 4];
    
end
