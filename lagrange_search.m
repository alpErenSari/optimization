function alpha = lagrange_search(f_a, low, max)
    a = linspace(low, max, 3);
    f1 = f_a(a(1));
    f2 = f_a(a(2));
    f3 = f_a(a(3));
    
%     gama_1 = @(a) (a - a(2))*(a - a(3))/((a(1)- a(2))*(a(1) - a(3)));
%     gama_2 = @(a) (a - a(1))*(a - a(3))/((a(2)- a(1))*(a(2) - a(3)));
%     gama_3 = @(a) (a - a(1))*(a - a(2))/((a(3)- a(1))*(a(3) - a(2)));
%     
%     q = @(a) f1*gama_1(a) + f2*gamma_2(a) + f3*gamma_3(a);
    
    res = (f1*(a(2) + a(3))/((a(1) - a(2))*(a(1) - a(3))) + ...
        f2*(a(1) + a(3))/((a(2) - a(1))*(a(2) - a(3))) + ...
        f3*(a(1) + a(2))/((a(3) - a(1))*(a(3) - a(2)))) / ...
        (f1*2/((a(1) - a(2))*(a(1) - a(3))) + ...
        f2*2/((a(2) - a(1))*(a(2) - a(3))) + ...
        f3*2/((a(3) - a(1))*(a(3) - a(2))));
    if (res >= low) && (res <= max)
        alpha = res;
    else
        if(f1 > f2)
            alpha = a(1);
        else
            alpha = a(2);
        end
    end
    
    
    