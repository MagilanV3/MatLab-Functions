function f = DERIV(t,x)
f = zeros(1,6);
y = t(2) - t(1);
x1 = (x(2) - x(1))/y;
f(1) = x1;
len = length(x);
c = length(x)-1;

for len = 2:c
    x2 = (x(len+1)-x(len-1))/(2*y);
    f(len) = x2;
end

x3 = (x(length(x))-x(length(x)-1))/y;
f(length(x)) = x3;

end 
© 2022 GitHub, Inc.