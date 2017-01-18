function nonlinearmin(f,start,method,tol,printout)
y = start;
cont = 1;
count = 0;
f(start)
while cont
    D = eye(length(start));
    for j = 1:length(y)
        gy = grad(f,y);
        d = -D*gy;
        lambda = linesearch(f,y,d);
        ynew = y + lambda*d;

        p = lambda*d;
        q = grad(f,ynew)-gy;
        if strcmp(method,'DFP')
            D = DFP(D,p,q);
        elseif strcmp(method,'BFGS')
        
        else
            disp('error')
            break;
        end
        y = ynew;
    end
    if printout
        disp('Print')
    end
    if p<tol
        cont = 0;
    end
    count = count + 1;
end
f(ynew)
count
end

