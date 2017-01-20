function y = func313(x)
%FUNC313 Summary of this function goes here
%   Detailed explanation goes here
t = 1;
for i = 1:length(x)
    t = t*x(i);
end
y = exp(t);
end

