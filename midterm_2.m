% This is the mt2 matlab implementation of ee553 optimization course.
% written by alp eren sari
f = @(x) -2*x(1) + x(2);
f_grad = @(x) [-2; 1];
h = @(x) -x(1).^2 + x(2);
h_grad = @(x) [-2*x(1); 1];
g = @(x) 0;
g_grad = @(x) [0; 0];

x0 = [0; -2]; i_max = 1000; M = 1;
constraints = {h, h_grad, g, g_grad};

[x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max)

%% question 2 barrier function 

f = @(x) x(1) - x(2) + x(2).^2;
f_grad = @(x) [1; (2*x(2) - 1)];
h = @(x) inf;
h_grad = @(x) [0; 0];
g = @(x) [-x(1); -x(2)]; % since algorithm implemented to make gi < 0
g_grad = @(x) [[-1; 0] [0; -1]];

x0 = [2; 3]; i_max = 1000; M = 1;
constraints = {h, h_grad, g, g_grad};

[x_sol, i] = barrier_question_2(f, f_grad, constraints, M, x0, i_max)

%% question 4 level set

[X,Y] = meshgrid([-5:.25:5]);
Z = (X.^4)/4 + (Y.^2)/2 - X.*Y + X - Y;
[c,h] = contour(X, Y, Z, [-0.72,-0.55,-0.2,0.5,2])
clabel(c,h);
title('Question 4 Level Set');
xlabel('x1'); ylabel('x2');
grid;

%% question 4 DFP method

f = @(x) (x(1)^4)/4 + (x(2).^2)/2 - x(1)*x(2) + x(1) - x(2);
f_grad = @(x) [(x(1)^3 - x(2) + 1); (x(2) - x(1) - 1)];

x0 = [0; 0]; H0 = eye(2); i_max = 1000; error = 1e-6;
[sol, i] = rank_2(f, f_grad, x0, H0, i_max, error)
keyboard
