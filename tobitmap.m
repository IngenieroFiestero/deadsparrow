function matrix = tobitmap(x, y, x_size, y_size, matrix)
% inputs
% x = coordinates x of the function to represent (max 1 min -1)
% y = coordinates y of the function to represent (max 1 min -1)
% x_size = x size of the output matrix
% y_size = y size of the output matrix
% matrix = to update this matrix, instead of creating a new one
if(nargin == 4)
    matrix = zeros(x_size, y_size);
end
x = round(x/2*x_size);
x(x==-x_size/2) = -x_size/2+1;
x(x==x_size/2) = x_size/2-1;
y = round(y/2*y_size);
y(y==-y_size/2) = -y_size/2+1;
y(y==y_size/2) = y_size/2-1;
for i = 1:length(x)
    matrix(x_size/2+x(i),y_size/2+y(i)) = matrix(x_size/2+x(i),y_size/2+y(i)) + 1;
end