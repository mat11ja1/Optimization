
start = repmat([-2;2;2;-1;-1],5,5);
tol = 1e-10;
eta = [0.01,0.1,1,10,100];

solver(@func313,@alfa313,eta,start,'DFP',tol,1)



