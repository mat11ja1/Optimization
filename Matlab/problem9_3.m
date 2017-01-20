f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);
p = @(x) (1/2*x(1) + x(2) - 1).^2;

x = [0; 0];
mu = 2.^(1:5:20);
[y, fy] = solver(f, p, mu, x, 'DFP', 1e-6, 0)
fprintf('Found point y: (%0.3f, %0.3f)\n', y(1), y(2))
fprintf('Minimum value: %0.3f\n', f(y)) 
fprintf('Penalty at y: %2.2E\n', p(y))