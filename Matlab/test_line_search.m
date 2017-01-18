tic
lambda_1=linesearch(@test_func,[0;0],[1;0])
test_func([0;0] + lambda_1*[1;0])
toc
tic
lambda_2=linesearch(@test_func,[0;0],[0;1])
test_func([0;0] + lambda_2*[0;1])
toc