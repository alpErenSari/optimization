N = 20;
M = 10;
x = linspace(0,5,N);
y0 = linspace(2,4,N);

area_x =  @(y) 2*pi*(5/N)*sum(y) + M*sum(y.^2);
length_curve = @(y) sum((y(2:end)-y(1:end-1)).^2 + (x(2:end)-x(1:end-1)).^2); 

% y_sol = fminunc(area_x, y0);

f = @(x) 2*pi*(5/N)*(sum(x) + 0.5*(2+x(1)) + 0.5*(x(end)+4));
f_grad = @(x) gradient_calculater(f, x);
h = @(x) 0;
h_grad = @(x) 0;
g = @(x) -x;
g_grad = @(x) -eye(length(x));
% unc_solver = 'fletcher_reeves';
% unc_solver = 'steepest_descent';
% unc_solver = 'rank_2_correction';
% unc_solver = 'newton_method';
unc_solvers = {'fletcher_reeves', 'steepest_descent', ...
    'rank_2_correction', 'newton_method'};
solver_name = {'Fletcher Reeves', 'Steepest Descent', ...
    'Rank 2 Correction', 'Newton Method'}
searchers = {'lagrange', 'golden', 'fibonacci', 'dichotomous', 'three_point'};
searchers_name = {'Lagrange', 'Golden Section', 'Fibonacci', 'Dichotomous', 'Three Point'};

x0 = y0(2:end-1)'; i_max = 20; M = 1; cnt = 0;
for a = 1:1
    for k = 1:4
        for l = 1:5
            if(a == 1)
                h = @(x) 0;
            elseif(a == 2)
                h = @(x) inf;
            end
            constraints = {h, h_grad, g, g_grad, unc_solvers{k}, searchers{l}};

            tic
            if(a == 1)
                [x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max);
            elseif(a == 2)
            	[x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max);
            end
            toc
            x_sol = [2; x_sol; 4];
            fig = figure;
            plot(x, x_sol);
            tit_str = ['The Minimum Surface Function with ', ...
                solver_name{k}, ' and ', searchers_name{l}]; 
            title(tit_str);
            xlabel('x');ylabel('y');
            fig_name = sprintf('../take_home/figures/%04d.png', cnt);
            saveas(fig, fig_name);
            cnt = cnt + 1;
        end
    end
end