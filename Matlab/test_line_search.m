%%
tic
[lambda_1, it] = linesearch(@test_func,[0;0],[1;0])
test_func([0;0] + lambda_1*[1;0])
toc
%%
tic
[lambda_2, it] = linesearch(@test_func,[0;0],[0;1])
test_func([0;0] + lambda_2*[0;1])
toc
%%
a=-2;   % try a = -2 too, then a = 5 and -5, then a = 10 and -10
func=@(x)(1-10^a*x)^2;
tic
[lambda_2, it] =linesearch(func,[0],[1])
func(lambda_2)
toc
%%
tic
[lb, k] = linesearch(@rosenbrock,[200;200], [-3.1840*1e9; 0.0080*1e9])
toc