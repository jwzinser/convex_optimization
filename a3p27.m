%A3.27
% affine policy.
m = 20; n = 10; p = 5;

randn('state',0); rand('state',0);
A = randn(m,n);
c = rand(n,1);
b0 = ones(m,1);
B = .15*sprandn(m,p,.3);

cvx_begin
variables x0(n) K(n,p)
minimize (c'*x0)
subject to
norm(A*K-B,1)<=b0-A*x0
cvx_end

%------------------DIFFERENT OBSERVATIONS-------------
rep=100;
objvalue=zeros(2,rep);
for i=1:rep
    u=unifrnd(-1,1,p,1);
    objvalue(1,i)=c'*(x0+K*u);
    cvx_begin quiet
    variable x(n)
    minimize (c'*x)
    subject to
    A*x<=b0+B*u
    cvx_end
    objvalue(2,i)=cvx_optval;
end
%%
   hold off 
scatter(objvalue(2,:),objvalue(1,:)) 
hold on
plot(linspace(-2,3,100),linspace(-2,3,100))



