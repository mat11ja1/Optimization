a = @(x) (sum(x.^2)-10)^2+(x(2)*x(3)-5*x(4)*x(5))^2+(x(1)^3+x(3)^3+1)^2;
f = @(x) exp(prod(x));
start = [-2;2;2;-1;-1];
% start = [-2;2;2;-1;-1];
% start3 = [0;0;5;-1;-.1];

tol = 1e-6;
eta = [0.01,0.1,1,10,100];

[y1d,fy1d,c1d] = solver(f,a,eta,start,'DFP',tol,0)
[y1b,fy1b,c1b] = solver(f,a,eta,start,'BFGS',tol,0);
% [y2d,fy2d,c2d] = solver(f,a,eta,start2,'DFP',tol,0);
% [y2b,fy2b,c2b] = solver(f,a,eta,start2,'BFGS',tol,0);
% [y3d,fy3d,c3d] = solver(f,a,eta,start3,'DFP',tol,0);
% [y3b,fy3b,c3b] = solver(f,a,eta,start3,'BFGS',tol,0);
