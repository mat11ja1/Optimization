function [y, fy, ctr] = solver(f, alpha, eta, start, method, tol, printout)
    y = start;
    ctr = 0;
    for i = 1:length(eta)
       q = @(y) f(y) + eta(i) * alpha(y);
       [y, fy, count] = nonlinearmin(q,y,method,tol,printout);
       ctr = ctr + count;
       if printout; fprintf('Penalty/Barrier: %2.2E, function value: %2.2E\n', eta(i), fy); end;
    end    
    fy = f(y);
end