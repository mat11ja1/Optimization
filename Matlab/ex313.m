a =@(x) max(0,(sum(x.^2)-10))^2+max(0,(x(2)*x(3)-5*x(4)*x(5)))^2+max(0,(x(1)^3+x(3)^3+1))^2;
f =@(x) exp(prod(x));
start = [-2;2;2;-1;-1];
tol = 1e-6;
eta = [0.01,0.1,1,10,100];

[y,fy] = solver(f,a,eta,start,'BFGS',tol,1);



