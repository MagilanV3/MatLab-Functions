function [y] = Myfactorial(x)
if x>0 & int8(x) == x & length(x) == 1  
    y = 1;
    for i = x:-1:1
        y = y * i;
    end
    disp([num2str(x) '! = ' num2str(y)])
else 
    y = 'Input must be a positive scalar integer';
    disp(y)
end