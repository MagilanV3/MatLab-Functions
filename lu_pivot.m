function [L,U,P,Q] = lu_pivot(A)
dim = length(A);
M = eye(dim);
N = eye(dim);

for i = 1 : dim-1
    pivot = max(max(abs(A([i:dim], [i:dim]))));
    
    [x,y] = find(abs(A([i:dim], [i:dim])) == pivot);
    if i ~= 1;
        x(1) = x(1) + (i-1);
        y(1) = y(1) + (i-1)