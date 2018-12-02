% this the question 4 of the ee553 mt 1
f_den = @(x) x.^2 - 9;
f_den_grad = @(x) 2*x ;
f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
f_grad = @(x) [200*(x(2)-x(1)^2)*(-2*x(1)) + 2*(x(1)-1); 200*(x(2)-x(1)^2)];
f_hessian = @(x) [[1200*x(1)^2 - 400*x(2) + 2, -400*x(1)]; [-400*x(1), 200]];

%% part a of the question 4
x0 = [-2; 2];
iterations = 1000;
error = 1e-8;
tic 
[sol, i, res] = steepest_descent(f, f_grad, x0, iterations, error)
toc
%% part b of the q 4
tic 
x0 = [-2; 2];
iterations = 100;
[sol, i, res] = parallel_tangents(f, f_grad, x0, iterations, error)
toc
%% part c of the question 4
x0 = [-2; 2];
iterations = 100;
tic
[x_sol, iteration] = fletcher_reeves (f, f_grad, x0, iterations)
toc
%% part d of the question 4
x0 = [-2; 2];
iterations = 10;
tic
[sol, i, res] = newton(f, f_grad, f_hessian, x0, iterations, error)
toc