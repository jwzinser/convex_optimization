%A5.13
%%
% data for censored fitting problem.
randn('state',0);

n = 20;  % dimension of x's
M = 25;  % number of non-censored data points
K = 100; % total number of points
c_true = randn(n,1);
X = randn(n,K);
y = X'*c_true + 0.1*(sqrt(n))*randn(K,1);
%%
% Reorder measurements, then censor
[y, sort_ind] = sort(y);
X = X(:,sort_ind);
D = (y(M)+y(M+1))/2;
y = y(1:M);
%%
%Regression with censored values
% yc=[y;D*ones(75,1)];
% 
% cvx_begin
% variable cc(20)
% minimize (norm(yc-(cc'*X)'))
% cvx_end
% 
% Xcensored=X(:,M+1:100);
% y=c'*Xcensored;
% y'
% 
% dif=norm(c_true-cc)/norm(c_true);
% %%
%normal least squares ignoring the censored data
%to compare the uncensored data we just need to make a cut without making
%new variables
%%
cvx_begin
variable cls(20)
minimize (norm(y-X(:,1:M)'*cls))
cvx_end
c_ls=cls

% dif=norm(c_true-cls)/norm(c_true)

%%

%using the censored data
cvx_begin
variables c(n) z(K-M)
minimize(sum_square(y-X(:,1:M)'*c)+sum_square(z-X(:,M+1:K)'*c))
subject to
z>=D
cvx_end
c_cens=c;
