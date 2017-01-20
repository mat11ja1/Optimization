function [y, fy] = nonlinearmin(f,start,method,tol,printout)
y = start;
cont = 1;
count = 0;
while cont
    fprintf('Outer-Iteration %d\n', count)
    cont2 = 1;
    yo = y;
    D = eye(length(start));
    for j = 1:length(y)
        if cont2 == 1
            gy = grad(f,y);
            d = -D*gy;
            [lambda, lsi] = linesearch(f,y,d);
            yold = y;
            y = y + lambda*d;

            p = lambda*d;
            gnew = grad(f,y); % for printout
            q = gnew-gy;
            if strcmp(method,'DFP')
                D = DFP(D,p,q);
            elseif strcmp(method,'BFGS')
                D = bfgs(D,p,q);
            else
                error('No method!')
            end
            delta_f = abs(f(yold) - f(y));
            %delta_y = abs(yold - y);
            if any(isnan(D(:))) || any(isinf(D(:)))
               cont2 = 0;
               %error('D is nan/inf') 
            end
            if (delta_f < tol) %| norm(delta_y) < tol
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
        disp('done!')
        cont = 0;
    end
    count = count + 1;
end
fy = f(y);
%count
end

