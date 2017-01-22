function [lambda,No_of_iterations] = linesearch(func,x,d)
% Function that does linesearch using a modified Golden Section method.
% Input: func = function
%        x = starting point
%        d = direction vector
% Output: lambda = optimal steplength
%         No_of_iterations = number of iterations to find the optimum

    a = find_interval(func, x, d, -10); % Starting point of the interval
    b = find_interval(func, x, d, 10); % End point of the interval
    alpha = (sqrt(5)-1)/2;
    lambda = a + (1-alpha)*(b-a); % Lambda for disecting the interval
    mu = a + alpha*(b-a); % Mu for disecting the interval
    f = @(y) func(x+d*y); % Function depending on steplength lambda
    No_of_iterations = 0;
    tol = 1e-8; % Tolerance
    fl = f(lambda);
    fm = f(mu);
    while abs(f(a)-f(b)) > tol && abs(f((a+b)/2)-(f(a)+f(b))/2) > tol   %abs(fl-fm) > tol%%abs(b-a) > tol && abs(fl-fm) > tol %abs(fl-fm) > tol% || abs(b-a) > 1e-9        
        No_of_iterations = No_of_iterations + 1;
        aold = a;
        if fl>fm
            a = lambda;
        else
            b = mu;
        end
        if a > 0 && f(a) > f(0) % Check if its better to not take a step
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
            warning('Infinity or nan in lambda or mu');
        end
        if lambda > mu
            warning('lambda > mu')
        end

    end
    
    v = [0, a, lambda, mu, b, (a+b)/2]; % Select lowest function value
    mins = zeros(size(v));
    for kk = 1:length(v)
        mins(kk) = f(v(kk));
    end
    [~, ik] = min(mins);
    lambda = v(ik);

    if isnan(func(x+lambda*d)) || func(x+lambda*d)>func(x)
        error('Bad job of the line search!')
    end
end
function p = find_interval(func, x, d, p) % Finding starting points
    while 1
        if isinf(func(x+p*d)) || isnan(func(x+p*d)) % Check if acceptable
            p = p / 10;
        else
            bold = p;
            p = p * 2;
            if ~(isinf(func(x+p*d)) || isnan(func(x+p*d)))
                if func(x+bold*d) < func(x+p*d) % Check if incresing 
                    break;                                           
                end
            end
        end
    end
end
