%{
This program solves problem 9_5 using both DFP and BFGS.
Additional printouts can be made by setting
printout = 1.
%}

printout = 0;

f = @(x) (x(1)-5)^2 + (x(2)-3)^2;
p = @(x) 1/(3-x(1)-x(2))+1/(4+x(1)-2*x(2)) + 1e10*(max(0,x(1)+x(2)-3) + max(0,-x(1)+2*x(2)-4));
tol = 1e-6;
x = [0; 0];
eps = [1 0.1 0.01 0.001 0.0001 0.00001 0.000001];
%eps = 1e-8, smallest possible start eps for both BFGS and DFP
%eps = 1e5, largest possible start eps for both BFGS and DFP

[y, fy, count] = solver(f, p, eps, x, 'DFP', tol, printout);
disp('DFP')
fprintf('Found point y: (%0.3f, %0.3f)\n', y(1), y(2))
fprintf('Minimum value: %0.3f\n', f(y)) 
fprintf('Penalty at y: %2.2E\n', p(y))
fprintf('Total iterations %d\n\n', count)
disp('BFGS')

[yl, fy, count] = solver(f, p, eps, x, 'BFGS', tol, printout);
fprintf('Found point y: (%0.3f, %0.3f)\n', yl(1), yl(2))
fprintf('Minimum value: %0.3f\n', f(y)) 
fprintf('Penalty at y: %2.2E\n', p(y))
fprintf('Total iterations %d\n\n', count)

fprintf('Norm of diff in y: %0.3E, f(y): %0.3E\n', norm(y-yl), norm(f(y)-f(yl)))
