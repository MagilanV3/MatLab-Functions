function[Jac] = JacobianFD(F,x,p)

for t = 1:length(F)
    m = 1;
    fun=@(x)func(m,1)
    Jac(t,m) = (fun(x(m)+p*x(m),x(m+1))-fun(x(m),x(m+1)))/(p*x(m))
    Jac(t,m+1) = (fun(x(m),x(m+1)+ p*x(m+1))-fun(x(m),x(m+1))/(p*x(m+1)));
    m=m+1;
end

end