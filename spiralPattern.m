function [ matrix ] = spiralPattern( n, pattern )
    matrix = zeros(n,n);
    i = ceil(n/2);
    j = ceil(n/2);
    matrix(i,j) = pattern(1);
    if n == 1, return, end
    k = 1;
    d = 1;
    count = 1;
    for p = 1:n
       q = 1:min(p,n-1);
       j = j+d*q;
       k = k+q;
       matrix(i,j) = pattern(q + count);
       count = count + length(q);
       if (p == n)
           return;
       end
       j = j(p);
       k = k(p);
       i = i+d*q';
       k = k+q';
       matrix(i,j) = pattern(q + count);
       i = i(p);
       k = k(p);
       d = -d;
       count = count + length(q);
    end
end