A = [400 200 150 500; 3 2 0 0; 2 2 4 4; 2 4 1 5];
A = [A -eye(4)];
b = [500 6 10 8];
c = -sum(A, 1);
x_sol = my_simplex(c, A, b);
res = isCanonical(x_sol);
[m,n] = size(A);

A2 = x_sol(1:m, 1:n);
c2 = [50 20 30 80];
c2_aug = [c2 zeros(1, n-m)];
b2 = x_sol(1:m, end);

for i = 1:n
    if(res(i) ~= 0)
        c2_aug = c2_aug - c2_aug(i)*A2(res(i), :);
    end
end

x_sol2 = simplex_phase_2(A2, b2', c2_aug)





