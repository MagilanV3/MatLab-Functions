% richardson22
% ============
% Subtractive Cancellation is affecting and ruining the approximations of 
% many formulas, such % as the 1st order forward divided-difference formula. 
% However, Richardson Extrapolation can  % be used to bypass this Catastrophic 
% Cancellation.
%
% Parameters
% ==========
%    D	The function D takes a function u and two real-values, x and h, and 
%       calculates an approximate of the derivative of function u at x. It
%       should take the form of D(u, x, h).
%    u	The function u is a real-valued function of a real variable. It
%       should take the form u(x).
%
%    x	The value at which the function will approximate
%    h	The step difference
%
%    N_max	    The maximum number of iterations the function will run to attempt 
%               to find a converging approximation.
%    eps_abs	If the difference between the previous approximation and 
%               the current approximation is less than eps_abs, the 
%               approximation is determined to be converging.
%
% Return Value
% ============
%    du		The approximation

function [du] = richardson22( D, u, x, h, N_max, eps_abs )
    % Argument Validation
    % Functions D
    if ~isa(D, 'function_handle')
        throw(MException('MATLAB:invalidInput', "The argument D is not a valid function"));
    end
    % Function u
    if ~isa(u, 'function_handle')
        throw(MException('MATLAB:invalidInput', "The argument u is not a valid function"));
    end
    % Scalar x
    if ~isscalar(x)
        throw(MException('MATLAB:invalidInput', "The argument x is not a real number"));
    end
    % Scalar h
    if ~isscalar(h)
        throw(MException('MATLAB:invalidInput', "The argument h is not a real number"));
    end
    % Scalar N_max (+ and Integer)
    if ~isscalar(N_max) || N_max <= 0 || N_max ~= round(N_max)
        throw(MException('MATLAB:invalidInput', "The argument N_max is not a positive integer number"));
    end
    % Scalar eps_abs (+)
    if ~isscalar(eps_abs) || eps_abs <= 0
        throw(MException('MATLAB:invalidInput', "The argument eps_abs is not a positive real number"));
    end
    
    
    % Calculations
    % Create 0's array
    R = zeros(N_max + 1);
    % Calculate first approximation
    R(1, 1) = D(u, x, h);
    % Start generating answer array
    for i = 1:N_max
        % Calculate first approximation for current row (i + 1)
        R(i + 1, 1) = D(u, x, h/(2^i));
        % Generate the rest of the row
        for j = 1:i
            % Calculate each approximation up until the diagonal
            R(i + 1, j + 1) = (4^j*R(i + 1, j) - R(i, j))/(4^j - 1);
        end
        % Test newest approximation for convergence
        if abs(R(i + 1, i + 1) - R(i, i)) < eps_abs
            % If success, return approximation
            du = R(i, i);
            return;
        % Otherwise, keep looping
        end
    end
    % If no approximation was found, error!
    throw(MException('MATLAB:noconverge', "There is no convergence approximation found with the current initial inputs."));
end