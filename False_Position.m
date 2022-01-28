syms x
f = inline(input('equation'));

i = 1;
while(i)
    xl = input('Lower value');
    xu = input('upper value');
    e = input('error');
    if f(xl)*f(xu)<0
        i=0;
    end
end

if f(xl)<0
    xn = xl;
    xp = xu;
else
    xn = xu;
    xp = xl; 
end
xm = xl;
t = 1;
while (abs(f(xm)) > e)
    xm = (xn*f(xp)-xp*f(xn))/(f(xp)-f(xn));
    t = t+1;
    if f(xm)<0
        xn = xm;
    else
        xp = xm;
    end
end

Root = xm 