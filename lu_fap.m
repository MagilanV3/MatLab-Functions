function [L,U,P,Q] = lu_fap(A)
% This function performs LU factorization for a matrix A. The function
% returns the lower and upper triangular matrices as separate matrices
% to make checking easier. It also returns matrices P and Q indicating
% the row and column exchanges, respectively. The function uses full

% pivoting, such that PAQ = LU. The matrix must be nonsingular and square.
% We will need to know the dimension of the matrix A.
dim = length(A);
% Initialize P and Q to the identity matrices.
P = eye(dim);
Q = eye(dim);
% For each row in A,
for i=1:dim-1
% Find the element with largest magnitude in each
% submatrix which will be the new pivot.
pivot = max(max(abs(A([i:dim],[i:dim]))));
% find the indeces of the new pivot
[x,y] = find(abs(A([i:dim],[i:dim])) == pivot);
if i~=1
x(1) = x(1) + (i-1);
y(1) = y(1) + (i-1);
end
% interchange the rows and columns of the new pivot
% with the old one
A([i,x(1)],:) = A([x(1),i],:);
A(:,[i,y(1)]) = A(:,[y(1),i]);
% store the changes in the matrices P and Q
P([i,x(1)],:) = P([x(1),i],:);
Q(:,[i,y(1)]) = Q(:,[y(1),i]);
% Compute the factor.
A(i+1:dim,i) = A(i+1:dim,i) / A(i,i);
% Multiply the "nonzero" elements of row i by the
% factor. Subtract this result from the "nonzero"
% elements of row j.
A(i+1:dim,i+1:dim) = A(i+1:dim,i+1:dim) - A(i,i+1:dim)*A(i+1:dim,i);
end
% For each row under row i,
for j=i+1:dim

% Check to see if we will encounter divide by zero.
if abs(A(i,i)) <= 1e-12
disp('The matrix is singular.')
U = NaN;
L = NaN;
return;
end
end
% The U factor is the upper triangle of A, with zeros
% in the lower triangle.
U = triu(A);
% The L factor is the lower triangle of A, with zeros
% in the lower triangle and ones along the main diagonal.
L = tril(A,-1) + eye(dim);