function [res, iteration] = newton_line(f, g, H, a, b, tol)

iteration = 0;
x = b;
x_old = a;
while((abs(g(x)) > tol) && (x > a))
    x = x - g(x)/H(x);
    x_old = x;
    iteration = iteration + 1;
    
end

res = x;

end