clc;
clear all;
func= @(x) (x^5-5*x^3-20*x+5);
A=input('Enter initial value : \n');
t(1)=input('Enter the step size : \n');
k1=func(A);
k2(1)=func(t(1));
i=2;
if k2<k1
    while k2<k1
        t(i)=2*t(i-1);
        k2(i)=func(t(i));
        i=i+1;
    end
  B=t(i-2);
  C=t(i-1);
end
y=1;
iteration=0;
while y>.0001
p=(A-B)*(B-C)*(C-A);
a=[func(A)*B*C*(C-B)+func(B)*C*A*(A-C)+func(C)*A*B*(B-A)]/p;
b=[func(A)*(B^2-C^2)+func(B)*(C^2-A^2)+func(C)*(A^2-B^2)]/p;
c=-1*[func(A)*(B-C)+func(B)*(C-A)+func(C)*(A-B)]/p;
lambda=-1*b/[2*c];
h=a+b*lambda+c*lambda^2;
f=func(lambda);
y=abs([h-f]/f);
if lambda>B && f<func(B)
    A=B;
    B=lambda;
    C=C;
else if lambda > B && f>func(B)
        A=A;
        B=B;
        C=lambda;
    else if lambda < B && f<func(B)
            A=A;
            B=lambda;
            C=B;
        else if lambda<B && f>func(b)
                A=lambda;
                B=B;
                C=C;
            end
        end
    end
end
iteration=iteration+1;
end
disp(func(lambda));
disp(lambda);
disp(iteration);

