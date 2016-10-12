%Final Exam 5
% Risk budget allocation

Sigma = [ 6.1 , 2.9 , -0.8 , 0.1;
          2.9 , 4.3 , -0.3 , 0.9;
        - 0.8 , -0.3 , 1.2 , -0.7;
          0.1 , 0.9 , -0.7 , 2.3];
      
 n=4;

 %%
cvx_begin
variable x(4)
minimize (.5*x'*Sigma*x-sum(log(x)/n))
subject to 
ones(1,4)*x==1
cvx_end
 
x