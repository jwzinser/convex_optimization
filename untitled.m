%minimization script for homework #4

%restrictions
%[2,1]*x>=1
%[1,3]*x>=1

%x1+x2
c=[1,1];
cvx_begin
variable x(2)
minimize(c*x)
subject to
[2,1]*x>=1
[1,3]*x>=1
cvx_end

