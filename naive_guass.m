function [X] = naive_guass(A,b);
[row,column] = size(A);
if row == column
    if length(A) == length(b)
        if det(A) > 0 
            n = row;
            X = zeros(size(b));
            for k = 1:n-1
                for i = k+1:n
                    for j = k+1:n
                        A(i,j) = A(i,j) - (A(i,k) / A(k,k)) * A(k,j);
                    end
                    b(i, :) = b(i, :) - (A(i,k) / A(k,k)) * b(k, :);
                end
            end

            X(n, :) = b(n, :) / A(n,n);
            for i = n-1:-1:1
                sum = b(i, :);
                for j = i+1:n
                    sum = sum - A(i,j) * X(j, :);
                end
                X(i, :) = sum / A(i,i);
            end
        else
            X = 'Matrix [A] is a singular matrix';
        end
    else
        X = 'Matrix dimension mismatch';
    end
else
    X = 'Matrix [A] is not a square matrix';
end