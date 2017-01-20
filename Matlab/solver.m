function [y, fy] = solver(f, alpha, eta, start, method, tol, printout)
    for i = 1:length(eta)
       q = @(y) f(y) + eta(i) * alpha(y);
       [y, fy] = nonlinearmin(q,start(i),method,tol,printout);
    end
end