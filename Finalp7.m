%Final Exam 7
% Numerical linear algebra with a fast operator
times=zeros(10,5);%here i will save the times for the different n's
ns=[1000,2500,5000,7500,10000];
for i=1:5
    % dimensions
    n = ns(i);
    p = 100;
    
    for j=1:10

        % Generate random problem instance
        B = randn(n,p);
        c = randn(p);
        C = c + c.';

        x = randn(n,1);
        y = randn(p,1);
        f = my_dct(x) + B*y;
        g = B'*x + C*y;   

        %solve 
        t0=tic;
        ye=(C-B'*my_idct(B))\(g-B'*my_idct(f));
        xe=my_idct(f)-my_idct(B*ye);
        times(j,i)=toc(t0);
    end
end
%%
avg_time=mean(times);
scatter(ns,avg_time)
% xlabel('n')   
% ylabel('average time')
title('Efficient solver N vs. avg_time')