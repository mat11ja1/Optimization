f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);
p = @(x) (1/2*x(1) + x(2) - 1).^2;

%f([1;2]) + b([1;2])

x = [0; 0];
mu = [4, 3, 2];
%nonlinearmin(f,start,method,tol,printout)
[y, fy] = solver(f, p, mu, x, 'DFP', 1e-6, 1)