function [lambda,No_of_iterations] = linesearch(func,x,d)
    f = @(y) func(x+d*y);
    lambda = 10;
    f0 = f(0);
    for i = 1:50
        if f(lambda) < f0
            break;
        end
        lambda = lambda / 2;
    end
    No_of_iterations = i;
end