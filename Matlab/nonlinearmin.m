function [y, fy, count] = nonlinearmin(f,start,method,tol,printout)
% Solves nonlinear problem using bfgs or dfp.
% inputs as per manual
% outputs minimum found point, minimum found function
%   value and number of outer iterations
y = start;
cont = 1; % continue outer loop
count = 1; % count outer iterations
while cont
    if printout; fprintf('Outer-Iteration %d\n', count+1); end
    cont2 = 1;
    yo = y;
    D = eye(length(start));
    for j = 1:length(y)
        if cont2 == 1
            gy = grad(f,y);
            d = -D*gy;
            [lambda, lsi] = linesearch(f,y,d); % Perform linesearch
            yold = y;
            y = y + lambda*d;

            p = lambda*d;
            gnew = grad(f,y); % for printout purposes
            q = gnew-gy;
            if strcmp(method,'DFP')
                D = DFP(D,p,q);
            elseif strcmp(method,'BFGS')
                D = bfgs(D,p,q);
            else
                error('No method specified!')
            end
            delta_f = abs(f(yold) - f(y));
            if any(isnan(D(:))) || any(isinf(D(:))) % Sign of lambda or d equal to zero
               cont2 = 0; 
            end
            if (delta_f < tol) % Break inner loop if within tolerance
               cont2 = 0;
            end
        end
        if printout
            fprintf('It \tx \ts.s \tf(x) \t|grad| \tl.s.i. \tlambda\n')
            fprintf('%d \t%0.2f \t%0.2f \t%0.2f \t%0.2f \t%d \t%1.2E\n', j, y(1), norm(p), f(y), norm(gnew), lsi, lambda)
            fprintf(' \t%0.2f\n', y(2:end))
        end
    end
    if (norm(f(y) - f(yo)) < tol) || norm(yo-y) < tol
        if printout; disp('Within tolerance, done!'); end;
        cont = 0;
    else
        count = count + 1;
    end
end
fy = f(y);
end

