function val = fibonacci(n);
    f0 = 1;
    f1 = 2;
    val = zeros(1,n);
    val(1) = 1;
    if(n >= 2)
        val(2) = 1;
        for i = 3:n
            val(i) = val(i-1) + val(i-2);
        end
    end
end
        
    