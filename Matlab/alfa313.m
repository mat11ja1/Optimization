function [ alfa ] = alfa313(x)

alfa = max(0,sum(x.^2-10)^2)+max(0,(x(2)*x(3)-5*x(4)*x(5))^2)+max(0,(x(1)^3+x(3)^3+1)^2);

end

