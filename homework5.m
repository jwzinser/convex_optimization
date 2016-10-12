%--------------Homework 5 Juan Zinser-----------------

%problem A3.18 boolean relaxation
rand('state',0);
n=100;
m=300;
A=rand(m,n);
b=A*ones(n,1)/2;
c=-rand(n,1);
%relaxed
%%
cvx_begin
variable x(n)
minimize( c'*x )
subject to
A*x<=b
0<=x<=1
cvx_end

%%
%threshold
%we need to get the plot of t vs objective value and max violation.
l=c'*x;
t=linspace(0,1,100);
a=x;
obj=[]; %saves the objective value for every t
maxviol=[];
for i=1:100
    for j=1:100
        if x(j)<t(i)
            a(j)=0;
        else
            a(j)=1;
        end
    end
    obj=[obj,c'*a];
    maxviol=[maxviol,maxviolation(A,a,b)];
end
 %%   
plot(t,obj,'Linewidth',3)
title('t vs objective (blue/increasing) and maxviolation (red/decreasing)')
xlabel('t')
hold on
plot(t,maxviol,'r','Linewidth',3)
plot(t,zeros(1,100),'ko')
plot(.62,0,'ms','Linewidth',6)


l
u=min(obj(find(maxviol<=0)))   
        