%A13.15 investment
%A13.15 investment
% data generation for sparse index tracking problem
% generates n, c, rbar, Sigma

rand('state',1);
randn('state',1);

n = 500; % number of stocks
k = 20;  % number of factors (not described or needed in problem statement)

% generate rbar, Sigma
F = 1.5*rand(n,k)-0.5; % factor matrix, entries uniform on [-0.5,1]
Sigma = 0.5*F*diag(rand(k,1))*F' + diag(0.1*rand(n,1));
mu_rf = 0.2;                          % risk-free return (weekly, 5% annual)
SR = 0.4;                             % Sharpe ratio
rbar = mu_rf + SR*sqrt(diag(Sigma));  % expected return
c = 5 + exp(2*randn(n,1));            % market capitalization (index weights)

cvx_begin
variables w(500) t
maximize sum(abs(w)<.01)
subject to
(.9*c-w)'*Sigma*(.9*c-w)+((c-w)'*rbar)^2-.1*(c'*rbar)^2<=0
cvx_end

