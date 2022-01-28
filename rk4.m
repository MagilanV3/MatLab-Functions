% ==========
% 4th Degree Runge Kutta method
% ==========
% When solving for an approximation of the solution of an initial value 
% problem where h is small. 4th Degree Runge Kutta method can be used as 
% it uses the average of 4 tangent lines to the solution curve through 
% (x0,y0) to obtain such approximation.
% ==========
% Parameters
% ==========
%    f      A function handle to the bivariate function
%    t_rng  A row vector of two values which contain the endpoints
%    y0     The initial condition
%    n      The number of points that we will break the interval (t_rng) into
% =============
% Return Values
% =============
%    t_out  A row vector of n equally spaced values between the interval
%           (t_rng) 
%    y_out  A row vector of n values where y_out(1) equals y0 and y_out(k) 
%           approximates y(t) at t_out(k) for k from 2 to n 
% ==========
function [t_out, y_out] = rk4(f, t_rng, y0, n)
    % Argument Checking
    if ~isa( f, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument z is not a function handle' ) );
    end
    if ~all( size( t_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument t_rng is not a 2-dimensional row vector' ) );
    end
    if ~isscalar( y0 ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument y0 is not a scalar' ) );
    end
    if ~isscalar( n ) || (n ~= round( n ))  || (n <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument n is not a positive integer' ) );
    end
    % Find step variable
    h = (t_rng(2) - t_rng(1))/(n - 1);
    % Find t_out
    t_out = t_rng(1):h:t_rng(2); 
    % Setup y_out
    y_out = zeros(1,n);
    % Set first y_out as y0
    y_out(1) = y0;
    % Calculate rest of y_out with 4th Degree Runge Kutta Formula
    for i = 2:n
        % Calculate K1
        K1 = f(t_out(i - 1), y_out(i - 1));
        % Calculate K2
        K2 = f(t_out(i - 1) + h/2, y_out(i - 1) + h*K1/2);
        % Calculate K3
        K3 = f(t_out(i - 1) + h/2, y_out(i - 1) + h*K2/2);
        % Calculate K4
        K4 = f(t_out(i - 1) + h, y_out(i - 1) + h*K3);
        % Calculate Actual y_out
        y_out(i) = y_out(i - 1) + h*(K1/6 + K2/3 + K3/3 + K4/6);
    end
end