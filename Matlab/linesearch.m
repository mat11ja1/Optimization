function [lambda,No_of_iterations] = linesearch(func,x,d)
    %a = find_start_interval(func, x, d);
    a = 0;
    %b = find_end_interval(func, x, d);
    b = 10;
    alpha = (sqrt(5)-1)/2;
    lambda = a + (1-alpha)*(b-a);
    mu = a + alpha*(b-a);
    f = @(y) func(x+d*y);
    No_of_iterations = 0;
    tol = 1e-15;
    fl = f(lambda);
    fm = f(mu);
    %while abs(fl-fm) > tol%abs(fl-fm) > tol%%abs(b-a) > tol && abs(fl-fm) > tol %abs(fl-fm) > tol% || abs(b-a) > 1e-9        
    for ccc = 1:5
        No_of_iterations = No_of_iterations + 1;
        if fl>fm
            a = lambda;
        else
            b = mu;
        end        
        mu = a + alpha*(b-a);
        lambda = a + (1-alpha)*(b-a);
        fm = f(mu);
        fl = f(lambda);
        
        if isnan(f(lambda)) || isinf(f(lambda)) || isnan(f(mu)) || isinf(f(mu))
            error('inf?');
        end
        if lambda > mu
            error('lambda > mu?')
        end
        fprintf('a:%1.2E, b:%1.2E, %1.2E\n', a, b, (a+b)/2)
    end
    
    v = [0, a, lambda, mu, b, (a+b)/2]; % Select lowest function value
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
        if isnan(func(x+lambda*d))
           fprint('isnan!\n')
        end
        if func(x+lambda*d)>func(x)
            fprintf('%2.2f > %2.2f\n', func(x+lambda*d), func(x))
        end
        error('Bad job of the line search!')
    end
end
function b = find_end_interval(func, x, d)
    b = 10;
    while 1
        if isinf(func(x+b*d)) || isnan(func(x+b*d))
            b = b / 10;
        else
            bold = b;
            b = b * 2;
            if ~(isinf(func(x+b*d)) || isnan(func(x+b*d)))
                if func(x+bold*d) < func(x+b*d)
                    b = bold;
                    break;
                end
            end
        end
    end
end
function a = find_start_interval(func, x, d)
    a = -1;
    while isinf(func(x+a*d)) && a < -1e-100
        a = a / 2;
    end
end
