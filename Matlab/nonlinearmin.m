function nonlinearmin(f,start,method,tol,printout)
y = start;
cont = 1;
while cont
    D = eye(length(start));
    for j = 1:length(x)
        d = -D*grad(y);
        lambda = linesearch(f,y,d);
        ynew = y + lambda*d;

        p = lambda*d;
        q = grad(ynew)-grad(y);
        if strcmp(method,'DFP')
            
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
    
end

end

