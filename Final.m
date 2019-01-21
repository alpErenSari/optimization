% this is the ee553 final implementations
% by Alp Eren SARI

%% question 3
A = [2 2 1 2; 0 1 2 3; 2 1 0 0; 0 1 0 0; 0 0 -1 2; 0 0 1 2];
A = [A eye(6)];
b = [6 4 5 1 2 6];
c = -sum(A, 1);

x_sol = my_simplex(c, A, b);
res = isCanonical(x_sol);
[m,n] = size(A);

A2 = x_sol(1:m, 1:n);
c2 = [-4 -1 -3 -2];
c2_aug = [c2 zeros(1, m)];
b2 = x_sol(1:m, end);

for i = 1:n
    if(res(i) ~= 0)
        c2_aug = c2_aug - c2_aug(i)*A2(res(i), :);
    end
end

x_sol2 = simplex_phase_2(A2, b2', c2_aug)

%% question 8

f = @(x) (x(1)-5)^2 + (x(2)-3)^2;
f_grad = @(x) 0;
h = @(x) 0; % for penalty function
% h = @(x) inf; % for barrier function
h_grad = @(x) 0;
g = @(x) [3*x(1)+2*x(2)-6; -4*x(1)+2*x(2)-4];
g_grad = @(x) 0;

unc_solvers = {'fletcher_reeves', 'steepest_descent', ...
    'rank_2_correction', 'newton_method'};
searchers = {'lagrange', 'golden', 'fibonacci', 'dichotomous', 'three_point'};

x0 = [0.5 1]'; i_max = 1000; M = 10;
constraints = {h, h_grad, g, g_grad, unc_solvers{1}, searchers{1}};

[x_sol, i] = penalty(f, f_grad, constraints, M, x0, i_max)
% [x_sol, i] = barrier(f, f_grad, constraints, M, x0, i_max)

%% question 5
c = [-3 -2 5 0]';
H = [1 0.5 0 0; 0.5 1.5 -0.25 0; 0 0.25 1 0.5; 0 0 0.5 1.5];
A = [3 1 2 0; -2 1 3 1];
b = [8 6];

f = @(x) c'*x + 0.5*x'*H*x;
g = @(x) c + H*x;
x1 = [0 2 3 -5]';
D1 = eye(4);

[x_sol, it] = fin_q_5(f, g, H, c, A, x1, D1)

%



