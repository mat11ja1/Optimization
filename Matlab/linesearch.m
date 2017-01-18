function [lambda,No_of_iterations] = linesearch(func,x,d)
    a = 0;
    b = find_end_interval(func, x, d);
    alpha = (sqrt(5)-1)/2;
    lambda = a + (1-alpha)*(b-a);
    mu = a + alpha*(b-a);
    f = @(y) func(x+d.*y);
    No_of_iterations = 0;
    tol = 1e-90;
    fl = f(lambda);
    fm = f(mu);
    while abs(fl-fm) > tol
        No_of_iterations = No_of_iterations + 1;
        fl = f(lambda);
        fm = f(mu);
        if fl>fm
            a = lambda;
            lambda = mu;
            mu = a + alpha*(b-a); 
        end
        if fl<=fm
            b = mu;
            mu = lambda;
            lambda = a + (1-alpha)*(b-a);
        end
    end
    lambda = (a+b)/2;    
    % if isnan(func(x+lambda*d)) || func(x+lambda*d)>func(x)
    % error('Bad job of the line search!')
    % end
end
function b = find_end_interval(func, x, d)
    b = 1e100;
    while isinf(func(x+b*d))
        b = b / 2;
    end
    
end
