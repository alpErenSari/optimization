function res = isCanonical(A)
    [m,n] = size(A);
    
    I = eye(m);
    
    res = zeros(1,n);
    for j = 1:n
        for i = 1:m
            if(isequal(A(:,j), I(:,i)))
                res(j) = i;
            end
        end
    end
end