f = @(x) x.^2 - 2*x + 1;
g = @(x) 2*x - 2;
rosenbrock = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
rosenbrock_grad = @(x) [200*(x(2)-x(1)^2)*(-2*x(1)) + 2*(x(1)-1); 200*(x(2)-x(1)^2)];
hessian_rosen = @(x) [[1200*x(1)^2 - 400*x(2) + 2, -400*x(1)]; [-400*x(1), 200]];

%[res, it] = golden_section(f, -100, 100, 0.01);
% [a_max, result] = a_max_calculate(f, g, 1.01)
%% new part
x = [1 , 2];
% rosenbrock(x);
% rosenbrock_grad(x);
% hessian_rosen(x);
% linsolve(hessian_rosen(x), -rosenbrock_grad(x))
x0 = [17; 25];
tic
[sol, it, res] = newton(rosenbrock, rosenbrock_grad, hessian_rosen, x0, 1000, 1e-2)
toc
%%
% rosenbrock(sol)
% f_a = @(a)  rosenbrock(x0 - a*rosenbrock_grad(x0))
% [res, it] = golden_section(f_a, 0, 1e-8, 1e-8)
% g0 = rosenbrock_grad(x0);
% f_0 = rosenbrock(x0);
% tic
% sol = fminunc(rosenbrock, x0);
% toc
% fibo = fibonacci([1:50]);
% tic 
% [sol, it] = fibonacci_search(f, -1, 10, fibo, 1e-4)
% toc

%% conj. gradient test part

x0 = [-2; -2]; i_max = 1000; M = 1;
f=@(x) ( x(1) + 2 )^2 + ( x(2) + 3 )^2 + 4;
f_grad=@(x)[ 2*( x(1) + 2 ) ; 2*( x(2) + 3 )];

h = @(x) (x(1) + 3).^2;
h_grad = @(x) [2*(x(1) + 3); 0];
g = @(x) [(x(1) - x(2) -5); x(2) - 5];
g_grad = @(x) [[1; -1], [0; 1]];

% h = @(x) [x(1)+1 ; x(2)+2];
% h_grad = @(x) [[1; 0], [0; 1]];
% g=@(x) 0;
% g_grad=@(x) 0;

constraints = {h, h_grad, g, g_grad};

[x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max)

%% rank 1 test
x0 = [2; -3]; i_max = 1000; M = 1; error = 1e-6;
f=@(x) ( x(1) + 1 )^2 + ( x(2) + 3 )^2 + 4;
f_grad=@(x)[ 2*( x(1) + 1 ) ; 2*( x(2) + 3 )];

[sol, i] = rank_1(rosenbrock, rosenbrock_grad, x0, i_max, error)

%% rank 2 test
x0 = [4; 3]; i_max = 1000; M = 1; error = 1e-6;
f=@(x) ( x(1) - 5 )^2 + ( x(2) + 3 )^2 + 4;
f_grad=@(x)[ 2*( x(1) - 5 ) ; 2*( x(2) + 3 )];

[sol, i] = rank_2(rosenbrock, rosenbrock_grad, x0, i_max, error)
