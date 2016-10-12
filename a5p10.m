%A5.10
% EE364a final 2008.
% Data file for identifying a sparse linear dynamical system.

% Generate a random, sparse system.
% Initialize both random generators, because sprandn uses both.
randn('state', 118); rand('state', 118);
n = 8;
A = full(sprandn(n, n, 0.2));
A = 0.95*A/max(abs(eig(A))); % make A stable.
m = 4;
B = full(sprandn(n, m, 0.3));
T = 100;
W = eye(n);
Whalf = sqrtm(W);

us = 10*randn(m, T-1); % input.
ws = Whalf*randn(n, T); % noise process.

xs = zeros(n, T);
xs(:, 1) = 50*randn(n, 1); % initial x.

% Simulate the system.
for t = 1:T-1
    xs(:,t + 1) = A*xs(:,t) + ws(:,t) + B*us(:,t);
end

%%
cvx_begin
    variables Ae(n,n) Be(n,m) 
    minimize (norm(xs(:,2:end)-Ae*xs(:,1:T-1)-Be*us(:,1:T-1),'fro'))
    subject to 
    norm(xs(:,2:end)-Ae*xs(:,1:T-1)-Be*us(:,1:T-1),'fro')<=n*(T-1)+2*sqrt(2*n*(T-1))
       
 cvx_end
 