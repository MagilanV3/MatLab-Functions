% ===============
% Shooting Method
% ===============
% The shooting method is a way to approximate the solution for a BVP by
% using the slopes. It uses the secant method to find the best slope, then
% uses dp45 to calculate a plot for the approximated solution.
% ==========
% Parameters
% ==========
%    s1        The first approximation of the slope
%    s2        The second approximation of the slope
%    f         The function
%    x_rng     The range to approximate
%    u_bndry   The boundary conditions
%    h         The initial step value
%    eps_abs   The maximum allowed difference
%    eps_step  The maximum allowed slope error
%    N_max     The maximum amount of iteration allowed
% =============
% Return Values
% =============
%    x_out  The x values of the approximated solution
%    u_out  The u values of the approximated solution
% =============
function [x_out, u_out] = shooting(s1, s2, f, x_rng, u_bndry, h, ...
        eps_abs, eps_step, N_max) 
    % Argument Checking
    if ~isscalar( s1 )
        throw( MException( 'MATLAB:invalidInput', ...
        'the argument s1 is not a real number' ) );
    end
    if ~isscalar( s2 )
        throw( MException( 'MATLAB:invalidInput', ...
        'the argument s2 is not a real number' ) );
    end
    if ~isa( f, 'function_handle' )
        throw( MException( 'MATLAB:invalidInput', ...
        'the argument f is not a function handle' ) );
    end
    if ~all( size( x_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalidInput', ...
        'the argument x_rng is not a 2-dimensional row vector' ) );
    end
    [~, u_bndry_cols] = size(u_bndry);
    if u_bndry_cols ~= 1
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument u_bndry is not a column vector' ) );
    end
    if ~isscalar( h )
        throw( MException( 'MATLAB:invalidInput', ...
        'the argument h is not a real number' ) );
    end
    if ~isscalar(eps_abs) || eps_abs <= 0
        throw(MException( 'MATLAB:invalid_argument', ...
            "The argument eps_abs is not a positive real number") );
    end
    if ~isscalar(eps_step) || eps_step <= 0
        throw(MException( 'MATLAB:invalid_argument', ...
            "The argument eps_step is not a positive real number") );
    end
    if N_max < 0 || floor(N_max) ~= N_max || isinf(N_max)
        throw(MException( 'MATLAB:invalid_argument', ...
            "The argument N_max is not a positive integer") );
    end
    % Test s1 and s2 to ensure correct order
    if abs(err_shot(s1, f, x_rng, u_bndry, h, eps_abs)) ...
            < abs(err_shot(s2, f, x_rng, u_bndry, h, eps_abs))
        % Swapping
        s_tmp = s1;
        s1 = s2;
        s2 = s_tmp;
    end
    % Loop for N_max times
    for i = 1:N_max
        % Find err_s2 and err_s1
        err_s1 = err_shot(s1, f, x_rng, u_bndry, h, eps_abs);
        err_s2 = err_shot(s2, f, x_rng, u_bndry, h, eps_abs);
        % Find s
        % TODO return NaN for sm reason at the end, must check
        s = (s1*err_s2 - s2*err_s1)/(err_s2 - err_s1);
        % Test if s is good, else continue
        if abs(s2 - s) < eps_step && abs(err_shot(s, f, x_rng, ...
                u_bndry, h, eps_abs)) < eps_abs
            [x_out, u_out] = dp45(f, x_rng, [u_bndry(1), s]', h, eps_abs);
            return;
        end
        % Reset and continue if failed to return
        s1 = s2;
        s2 = s;
    end
    % If all fail, exception is thrown
    throw( MException("MATLAB:noconverge", "Failed to find a solution " + ...
        "with the given parameters."));
end
