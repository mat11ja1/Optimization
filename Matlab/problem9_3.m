%{
This program solves problem 9_3 using both DFP.
Additional printouts can be made by setting
printout = 1.
%}

printout = 0;

f = @(x) exp(x(1)) + x(1)^2 + x(1)*x(2);
p = @(x) (1/2*x(1) + x(2) - 1).^2;

x = [0; 0];
mu = 10.^(1:6);
%mu = 1e18; % Largest possible start mu for DFP
[y, fy, count] = solver(f, p, mu, x, 'DFP', 1e-6, printout);
disp('DFP')
fprintf('Found point y: (%0.3f, %0.3f)\n', y(1), y(2))
fprintf('Minimum value: %0.3f\n', f(y)) 
fprintf('Penalty at y: %2.2E\n', p(y))
fprintf('Total iterations %d\n\n', count)
disp('BFGS')

%mu = 1e16; % Largest possible start mu for BFGS
[yl, fy, count] = solver(f, p, mu, x, 'BFGS', 1e-6, printout);
fprintf('Found point y: (%0.3f, %0.3f)\n', yl(1), yl(2))
fprintf('Minimum value: %0.3f\n', f(y)) 
fprintf('Penalty at y: %2.2E\n', p(y))
fprintf('Total iterations %d\n\n', count)

fprintf('Norm of diff in y: %0.3E, f(y): %0.3E\n', norm(y-yl), norm(f(y)-f(yl)))