function [a_max, result] = a_max_calculate(f, d, x)
    
    c = 10;
    a_max = c/(norm(d) + 1e-4);
    f_0 = f(x);
    iter1_max = 100;
    iter2_max = 100;
    iter3_max = 5;
    iter1 = 0;
    iter2 = 0;
    iter3 = 0;
    state = 2;
    result = 0;
    while(1)
        if(state == 1)
            a_max = c/(norm(d) + 1e-4);
            f_0 = f(x);
            iter1 = 0;
            iter2 = 0;
            state = 2;
            iter3 = iter3 + 1;
            if(iter3 >= iter3_max)
                break;
            end
            
        elseif(state == 2)
           if(f(x + d.*a_max./2) <= f_0)
               state = 3;
           else
               state = 6;
           end
           
        elseif(state == 3)
            if(f(x + d.*a_max./2) <= f(x + d.*a_max))
                state = 4;
            else 
                state = 5;
            end
        elseif(state == 4)
            result = 1;
            break;
        elseif(state == 5)
            a_max = 2*a_max;
            iter1 = iter1 + 1;
            state = 2;
            if(iter1 >= iter1_max)
                result = 1;
                break;
            end
        elseif(state == 6)
            a_max = a_max/2;
            iter2 = iter2 + 1;
            state = 2;
            if(iter2 >= iter2_max)
                c = c/100;
                state = 1;
            end
        end
%        display("while state number " + num2str(state) + " c is " + num2str(a_max));
    end
end
            
            
            