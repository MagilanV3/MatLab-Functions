% ==========
% Documentation Here
% ==========
function [t_out, y_out] = heun(f, t_rng, y0, n)
    % ==========
    % Parameter Checking will be here
    % ==========
    % Find step variable
    h = (t_rng(2) - t_rng(1))/(n - 1);
    % Find t_out
    t_out = t_rng(1):h:t_rng(2); 
    % Setup y_out
    y_out = zeros(1,n);
    % Set first y_out as y0
    y_out(1) = y0;
    % Calculate rest of y_out with Heun's Formula
    for i = 2:n
        % Calculate K1
        K1 = f(t_out(i - 1), y_out(i - 1));
        % Calculate K2
        K2 = f(t_out(i - 1) + h, y_out(i - 1) + h*K1);
        % Calculate Actual y_out
        y_out(i) = y_out(i - 1) + h*(K1 + K2)/2;
    end
end