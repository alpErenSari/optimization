function [x_sol, i] = fletcher_reeves (f, f_grad, x0, search, i_max)

x=x0;
epsilon = 1e-4;
c0 = f_grad(x); % evaluate gradient at initial point 
d0= -c0; % search direction 
alpha_max=a_max_calculate(f, d0, x);
f_a = @(a) f(x + a.*d0);
if(strcmp(search, 'lagrange'))
    alpha = lagrange_search(f_a, 0, alpha_max); %line search (step size)
elseif(strcmp(search, 'golden'))
    [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
elseif(strcmp(search, 'fibonacci'))
    fibo = fibonacci(50);
    [alpha, it] = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
elseif(strcmp(search, 'dichotomous'))
    [alpha, it] = dichotomous_search(f_a, 0, alpha_max, 1e-4);
elseif(strcmp(search, 'three_point'))
    [alpha, it] = threePointInterval(f_a, 0, alpha_max, 1e-4);
end
x= x+ alpha*d0;
c1 = f_grad(x); 
i=0;

      for i = 0:i_max
          beta = (norm(c1)/norm(c0))^2;         
          d1= -c1+beta*d0;
          alpha_max=a_max_calculate(f, d1, x);
          f_a = @(a) f(x + a.*d1);
          if(strcmp(search, 'lagrange'))
            alpha = lagrange_search(f_a, 0, alpha_max);
          elseif(strcmp(search, 'golden') )
            [alpha, it] = golden_section(f_a, 0, alpha_max, 1e-4);
          elseif(strcmp(search, 'fibonacci'))
            [alpha, it] = fibonacci_search(f_a, 0, alpha_max, fibo, 1e-4);
          elseif(strcmp(search, 'dichotomous'))
            [alpha, it] = dichotomous_search(f_a, 0, alpha_max, 1e-4);
          elseif(strcmp(search, 'three_point'))
            [alpha, it] = threePointInterval(f_a, 0, alpha_max, 1e-4);
          end
          
          x= x+ alpha*d1;
          
          d0=d1;
          c0=c1;
          c1= f_grad(x);
          if(norm(c1) < epsilon)
              break;
          end

      end
      x_sol = x;
      i = i + 1;
  end