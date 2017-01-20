function [y, fy] = solver(f, alpha, eta, start, method, tol, printout)
    y = start;
    for i = 1:length(eta)
       q = @(y) f(y) + eta(i) * alpha(y);
       [y, fy] = nonlinearmin(q,y,method,tol,printout);
    end
end