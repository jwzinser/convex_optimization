%Final exam 4
% Sparse approximate eigenvectors
%% Generate Data

n = 20;
randn('state',1)
x0 = sign(randn(n,1));
sp = [1 3 5 6 7 8 11 14 15 16 17 19];
x0(sp) = 0;
x0 = x0/norm(x0);
X0 = x0*x0';

noise = randn(n,n);
Z = (noise + noise')/sqrt(2);

lambda = 12;
A = lambda*X0 + Z;

k = 7.5;

%% Your code goes here
% It should produce an estimate x0_hat
cvx_begin
    variable X(n,n)
    X==semidefinite(n)
    minimize (trace(X*A))
    subject to
    trace(X)==1
    ones(1,n)*abs(X)*ones(n,1)<=k
cvx_end

x0_hat = zeros(n,1); %YOUR ESTIMATE HERE
for i=1:n
    x0_hat(i,1)=sqrt(X(i,i));
end
x0_hat

%% Analyze results

%leading eigenvector of A (for comparison)
[v,~] = eigs(A,1,'LA'); 

plot([x0,x0_hat,v]) %signs may be flipped

% Compute numbers true and false positives
tol = 0.01;
TP = sum(  x0 & (abs(x0_hat)>tol) ) 
FP = sum( ~x0 & (abs(x0_hat)>tol) )

TP2 = sum(  x0 & (abs(v)>tol) ) 
FP2 = sum( ~x0 & (abs(v)>tol) )
