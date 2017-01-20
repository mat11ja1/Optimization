f = @(x) (x(1)-5)^2 + (x(2)-3)^2;
p = @(x) 1/(3-x(1)-x(2))+1/(4+x(1)-2*x(2));

%f([1;2]) + b([1;2])

x = [0; 0];
eps = [0.01 0.1 1]% 10 100];
%nonlinearmin(f,start,method,tol,printout)
[y, fy] = solver(f, p, eps, x, 'DFP', 1e-6, 1)