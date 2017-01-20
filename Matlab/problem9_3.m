%{
TODO
DFP & BFGS:
Try different starting points

%}

f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);
p = @(x) (1/2*x(1) + x(2) - 1).^2;

x = [0; 0];
mu = 10.^(1:4:9);
[y, fy, count] = solver(f, p, mu, x, 'BFGS', 1e-6, 1);
fprintf('Found point y: (%0.3f, %0.3f)\n', y(1), y(2))
fprintf('Minimum value: %0.3f\n', f(y)) 
fprintf('Penalty at y: %2.2E\n', p(y))
fprintf('Total iterations %d\n\n', count)