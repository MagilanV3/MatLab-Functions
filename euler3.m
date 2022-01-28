% ==========
% Euler’s method
%When solving for an approximation of the solution of an initial-value 
%problem where x = x1 = x0 +h and where h is small. Euler's method can be 
%used as it uses the tangent line to the solution curve through (x0,y0) to 
%obtain such approximation.
% Parameters
% ==========
%    f      A function handle to the bivariate function
%    t_rng  A row vector of two values which contain the endpoints
%    y0     The initial condition
%    n      The number of points that we will break the interval (t_rng) into
% Return Values
% =============
%    t_out  A row vector of n equally spaced values between the interval
%           (t_rng) 
%    y_out  A row vector of n values where y_out(1) equals y0 and y_out(k) 
%           approximates y(t) at t_out(k) for k from 2 to n 

% ==========
function [t_out, y_out] = euler3(f, t_rng, y0, n)
    % Argument Checking
    % ==========
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

    % ==========
    % Find step variable
    h = (t_rng(2) - t_rng(1))/(n - 1);
    % Find t_out
    t_out = t_rng(1):h:t_rng(2); 
    % Setup y_out
    y_out = zeros(1,n);
    % Set first y_out as y0
    y_out(1) = y0;
    % Calculate rest of y_out with Euler's Formula
    for i = 2:n
        y_out(i) = y_out(i - 1) + h*f(t_out(i - 1), y_out(i - 1));
    end
end