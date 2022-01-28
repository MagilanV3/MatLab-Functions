function [L,U,P,Q] = lu_fp(A)
dim = length(A);
P = eye(dim);
Q = eye(dim);
for i=1:dim-1
pivot = max(max(abs(A([i:dim],[i:dim]))));
[x,y] = find(abs(A([i:dim],[i:dim])) == pivot);
if i~=1
x(1) = x(1) + (i-1);
y(1) = y(1) + (i-1);
end
A([i,x(1)],:) = A([x(1),i],:);
A(:,[i,y(1)]) = A(:,[y(1),i]);
P([i,x(1)],:) = P([x(1),i],:);
Q(:,[i,y(1)]) = Q(:,[y(1),i]);
A(i+1:dim,i) = A(i+1:dim,i) / A(i,i);
A(i+1:dim,i+1:dim) = A(i+1:dim,i+1:dim) - A(i,i+1:dim)*A(i+1:dim,i);
end

U = triu(A);
L = tril(A,-1) + eye(dim);
