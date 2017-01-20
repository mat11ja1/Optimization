function [lambda,No_of_iterations] = linesearch(func,x,d)
    a = find_interval(func, x, d, -10);
    b = find_interval(func, x, d, 10);
    alpha = (sqrt(5)-1)/2;
    lambda = a + (1-alpha)*(b-a);
    mu = a + alpha*(b-a);
    f = @(y) func(x+d*y);
    No_of_iterations = 0;
    tol = 1e-8;
    fl = f(lambda);
    fm = f(mu);
    while abs(f(a)-f(b)) > tol && abs(f((a+b)/2)-(f(a)+f(b))/2) > tol   %abs(fl-fm) > tol%%abs(b-a) > tol && abs(fl-fm) > tol %abs(fl-fm) > tol% || abs(b-a) > 1e-9        
        No_of_iterations = No_of_iterations + 1;
        if fl == fm
            warning('fl == fm')
        end
        aold = a;
        if fl>fm
            a = lambda;
        else
            b = mu;
        end
        if a > 0 && f(a) > f(0)
            warning('Not unimodal function')
            b = mu;
            mu = lambda;
            lambda = a;
            a = aold;
        end
        
        mu = a + alpha*(b-a);
        lambda = a + (1-alpha)*(b-a);
        fm = f(mu);
        fl = f(lambda);

        if isnan(f(lambda)) || isinf(f(lambda)) || isnan(f(mu)) || isinf(f(mu))
            error('Infinity or nan in lambda or mu');
        end
        if lambda > mu
            error('lambda > mu')
        end
        %fprintf('a-l: %1.2E, l-m: %1.2E, m-b: %1.2E, a-b: %1.2E\n', a-lambda, lambda-mu, mu-b, a-b) 
        %fprintf('a:%1.2E, b:%1.2E, %1.2E\n', a, b, (a+b)/2)
    end
    
    v = [a, lambda, mu, b, (a+b)/2]; % Select lowest function value
    mins = zeros(size(v));
    for kk = 1:length(v)
        mins(kk) = f(v(kk));
    end
    [~, ik] = min(mins);
    lambda = v(ik);
    %lambda = (a+b)/2;
    %if func(x+lambda*d) > func(x) || isnan(func(x+lambda*d))
    %    lambda = 0;
    %end
    if isnan(func(x+lambda*d)) || func(x+lambda*d)>func(x)
        error('Bad job of the line search!')
    end
end
function p = find_interval(func, x, d, p)
    while 1
        if isinf(func(x+p*d)) || isnan(func(x+p*d))
            p = p / 10;
        else
            bold = p;
            p = p * 2;
            if ~(isinf(func(x+p*d)) || isnan(func(x+p*d)))
                if func(x+bold*d) < func(x+p*d)
                    %p = bold;
                    break;                                           
                end
            end
        end
    end
end
