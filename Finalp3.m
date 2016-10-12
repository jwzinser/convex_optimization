%Final Exam 3
% Imaging under Poisson noise
%%
% dimensions
n = 30;
m = 30;

% create signal
x = ones(n,1);
x(ceil(n/3):floor(2*n/3))=3;
x(ceil(2*n/3):end)=2;
xorig = 10*x;

%measurement matrix
rand('state', 0);
A = 5*rand(m,n);

%sample
randn('state',6000);
y = poissrnd( A*xorig,m,1,0); 
%generate the matrix that will be used as log(yi!)
logyfact=zeros(m,1);
for ii=1:m
    for jj=1:y(i)
        logyfact(ii)=logyfact(ii)+log(jj);
    end
end

%%
%----------------------SOLUTION---------------------
%estimation via maximum likelihood
lambda=[.2,.6,1.5];
for i=1:3
    cvx_begin quiet
        variable x(n)
        aux=y'*diag(log(A*x));
        minimize (sum(A*x)-sum(aux)+sum(logyfact)+lambda(i)*sum(abs(x(2:n)-x(1:n-1))))
    cvx_end

    hold off
    subplot(3,1,i)
    auxp=[1:n];
    plot(auxp,xorig,'blue')
    hold on
    plot(auxp,x,'red')
    legend('xest(red)','xorig(blue)')
    title('Signal reconstruction from level information for lambda=(.2,.6,1.5)')
end

