function matrix = coordSpiral(tam)
matrix = 1;
i = 0.5;
while(i<tam)
    i = i + 0.5;
    switch(mod(i,2))
        case 0.5
            t = size(matrix,1);
            index = max(max(matrix));
            vector = (t:-1:1)' + index;
            matrix = [vector matrix];
        case 1
            t = size(matrix,2);
            index = max(max(matrix));
            vector = (1:t) + index;
            matrix = [vector; matrix];
        case 1.5
            t = size(matrix,1);
            index = max(max(matrix));
            vector = (1:t)' + index;
            matrix = [matrix vector];
        case 0
            t = size(matrix,2);
            index = max(max(matrix));
            vector = (t:-1:1) + index;
            matrix = [matrix; vector];
    end
end