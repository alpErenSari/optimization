f = @(x) (x(1)-5)^2 + (x(2)-3)^2;
f_grad = @(x) 0;
h = @(x) inf;
h_grad = @(x) 0;
g = @(x) [3*x(1)+2*x(2)-6; -4*x(1)+2*x(2)-4];
g_grad = @(x) 0;

unc_solvers = {'fletcher_reeves', 'steepest_descent', ...
    'rank_2_correction', 'newton_method'};
searchers = {'lagrange', 'golden', 'fibonacci', 'dichotomous', 'three_point'};

x0 = [0.5 1]'; i_max = 1000; M = 100;
constraints = {h, h_grad, g, g_grad, unc_solvers{1}, searchers{1}};

[x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max)
