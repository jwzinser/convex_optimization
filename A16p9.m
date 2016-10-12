%Exercise 16.9
%%
randn('seed', 1); 
T = 96; % 15 minute intervals in a 24 hour period
t = (1:T)'; 
p = exp(-cos((t-15)*2*pi/T)+0.01*randn(T,1)); 
u = 2*exp(-0.6*cos((t+40)*pi/T) -0.7*cos(t*4*pi/T)+0.01*randn(T,1));
plot(t/4, p); 
hold on
plot(t/4,u,'r');
title('price (blue) and utlization/per 15 min (red)')
xlabel('time in hours')

A=zeros(T);
for i=1:T-1
    A(i,i:i+1)=[-1 1];
end
A(T,1)=1; A(T,T)=-1;

cvx_begin
variables q(96) c(96)
minimize (p'*(u+c))
subject to
A*q==c
max(q)<=10
-1<=min(c)
1>=max(c)
q>=0
cvx_end
%%
% hold off
% plot(t,u)
% hold on
% plot(t,p)
% plot(t,c)
% plot(t,q)
%%