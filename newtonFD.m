function[sol,iter] = newtonFD(f,J,x0)
maxiter = 50;
tol = 0.001;
eps = 1;
xold = x0;
i = 0;
while eps>tol&&i <= maxiter
    i = i+1;
    Ja = feval(J,xold);
    xnew = xold - inv(Ja)*feval(f,xold);
    eps = max(abs((xnew-xold)./xnew));
    xold = xnew;
end
if eps > tol
    disp('Maximum iterations reached')
    sol=[]; 
    iter = maxiter;
else
    sol = xnew;
    iter = i;
end 
