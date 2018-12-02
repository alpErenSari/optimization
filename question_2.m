a = 1;
b = 2;
x = linspace(a,b,100);
f = @(x) 8*exp(1-x) + 7*log(x);

%% part a of the question 2
y = f(x);
figure
plot(x,y);
title('f(x) function in the interval [1,2]');
xlabel('x');
ylabel('f(x)');
%% part b of the question 2
tol = 1e-5;
tic
[res, iteration] = dichotomous_search(f, a, b, tol)
toc
%% partc of the queestion 2
tic
% 50 length fibonacci search
n = 10;
fibo = fibonacci(n);
[res, iteration] = fibonacci_search(f, a, b, fibo, tol)
toc
%% part d of the question 2
tic
[res, iteration] = golden_section(f, a, b, tol)
toc
%% part e of the question 2
tic
res = lagrange_search(f, a, b)
toc