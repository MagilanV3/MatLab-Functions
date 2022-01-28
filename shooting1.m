% The function returns the x and u-values corresponding to the optimal slope of a function inputted by the user
%
% Parameters
%
% For each parameter, give a brief description of the purpose of that parameter
%
%    s1        First approximation of the slope
%    s2        Second approximation of the slope
%    f         Function handle for the differential equation
%    x_rng     Row vector defining the range on which we are approximating
%    the Boundary value problem
%    u_bndry   Row vector defining the boundary conditions
%    h         Initial step size for the function dp45
%    eps_abs   Parameter passed to dp45 and is also parameter used by secant method
%    eps_step  Parameter used by secant method for step size
%    N_max     Parameter used by the secant method to define the maximum
%    number of iterations
%
% Return Values
%
% For each return value, give a brief description of its values
%
%   x_out      The x-values of the function’s slope
%   u_out      The u-values of the function’s slope

function [x_out, u_out] = shooting1( s1, s2, f, x_rng, u_bndry, h, eps_abs, eps_step, N_max )
%Checking Arguments
    if ~isa( f, 'function_handle' )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument f is not a function handle' ) );
    end
    
    if ~isscalar( eps_abs ) || (eps_abs <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument eps_abs is not a positive scalar' ) );
    end
    
    if ~isscalar( eps_step ) || (eps_step <= 0) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument eps_step is not a positive scalar' ) );
    end
    
    if ~isscalar( h) || (h<=0)
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument h is not a positive scalar.' ) );
    end
    
    if ~isscalar( N_max) || (N_max<=0)
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument N_max is not a positive scalar.' ) );
    end
    
    
    if ~all( size( x_rng ) == [1, 2] ) 
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument x_rng is not a 2-dimensional row vector' ) );
    end
    
    if ~isscalar( s1 )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument s1 is not a positive scalar' ) );
    end
    
    if ~isscalar( s2 )
        throw( MException( 'MATLAB:invalid_argument', ...
        'the argument s2 is not a positive scalar' ) );
    end

%Initializing variables 
    
    err1 = err_shot1( s1,f, x_rng, u_bndry, h, eps_abs );
    err2 = err_shot1( s2,f, x_rng, u_bndry, h, eps_abs );

%Creating a loop for the approximation of the slope, iterating from 1 to the maximum number of %iterations defied by user
    for k = 1:N_max
        if abs(err1) < abs(err2)
            s1_temp = s1;
            s1 = s2;
            s2 = s1_temp;
        end

%Calculating New slope
        s = (s1*err2 - s2*err1)/(err2-err1);
        errs = err_shot1(s,f, x_rng, u_bndry, h, eps_abs);
        if (abs(s2-s) < eps_step) && (abs(errs) < eps_abs)
            disp (s) 
        else 
            disp (s)
            s1 = s2;
            s2 = s;
            err1 = err_shot1(s1,f, x_rng, u_bndry, h, eps_abs);
            err2 = err_shot1(s2,f, x_rng, u_bndry, h, eps_abs);
            continue
        end
 % The message when the maximum number of iterations have been reached 
        if k == N_max
           disp ('The maximum number of iterations has been reached'); 
        end
        [x_out, u_out] = dp45( f, x_rng, [u_bndry(1), s]', h, eps_abs );
        return;
    end
end