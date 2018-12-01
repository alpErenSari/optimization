function [res, iteration] = threePointInterval(f, a, b, tol)
    L=b-a;
    x1=a+L/4;
    x2=b-L/4;
    xm=(a+b)/2;
    iteration=0;
    while (L>tol)
        if f(x1)<f(xm)
            b=xm;
        else
            if f(x2)<f(xm)
                a=xm;
            else
                a=x1;
                b=x2;
            end
        end
        L=b-a;
        x1=a+L/4;
        x2=b-L/4;
        xm=(a+b)/2;
        iteration=iteration+1;
    end
    res=(a+b)/2;