N = 100;
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
unc_solver = 'newton_method';

x0 = y0(2:end-1)'; i_max = 100; M = 1;
constraints = {h, h_grad, g, g_grad, unc_solver};

tic
[x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max);
toc
x_sol = [2; x_sol; 4];
plot(x, x_sol);