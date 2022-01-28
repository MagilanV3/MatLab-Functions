% Secant method
%
% Given two points, the function will use the secant method to find the 
% interpolating line that passes through them and then find the root of 
% that line. The function will take in the variables listed below and
% calculate the root of the line/curve(f) using the guesses (x0 & x1) while
% adhering to the set parameters(eps_step, eps_abs & N_max) explained below.
%
% Parameters                 
% ==========                 
%    f         function of the line/curve
%    x0        Intial guess for the root of f
%    x1        Another initial guess for the root of f
%    eps_step  The value is the maximum difference between two successive
%              approximations that can be considered close enough.
%
%    eps_abs   The value represents the acceptable difference between
%    function at x and the given value
%    N_max     The maximum number of iterations the algorithm will run 
%
% Return Values              
% =============
%    x2        This is the root of f dervived from the secant method

%{
function [x2] = secant( f, x0, x1, eps_step, eps_abs, N_max )
    for i = 1:N_max % the loop will run N_max number of times
        x2 = x1 - (f(x1)*(x0-x1))/(f(x0)-f(x1)); %Interpolating Polynomial
        if abs( x2 - x1 ) < eps_step && abs(f(x2)) < eps_abs %If the value meets the bounds of eps_step & eps_abs
            return;
        end
        x0 = x1;
        x1 = x2;
    end
    throw( MException( 'MATLAB:numeric_exception',...
        'Max iterations reached and therefore does not converge')); %Error message if it doesn't converge within the set amount of iterations
end
%}
function [x2] = secant( f, x0, x1, eps_step, eps_abs, N_max )
    for i = 1:N_max
        x2 = x1 - (f(x1)*(x0-x1))/(f(x0)-f(x1));
        if abs( x2 - x1 ) < eps_step && abs(f(x2)) < eps_abs 
            return;
        end
        x0 = x1;
        x1 = x2;
    end
    throw( MException( 'MATLAB:numeric_exception',...
        'Max iterations reached and therefore does not converge')); 

end


