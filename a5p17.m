%A5.17
%%
% Fitting a generalized additive regression model.
% Seed random number generator to get the same result every time
randn('state',0); rand('state',0);
N=2^8; n=9;

X=normrnd(0,6,N,n);

lambda=0.0391;

K=15;
p=-7:1:7;
%%
%Define the functions. (some have offsets so that f{i}(0)=0
a0=1.3;
f{1} =@(x) x/3;
f{2} =@(x) (x/7).^2;
f{3} =@(x) (x/8).^3;
f{4} =@(x) sin(x/10*pi);
f{5} =@(x) log(abs(x+13))-2.56494935746154;
f{6} =@(x) (abs(x)/8).^3.2-(x/8).^4;
f{7} =@(x) abs(x/5);
f{8} =@(x) log(exp(x)+exp((x/5).^2))/5-0.138629436111989;
f{9} =@(x) exp(x/10)-1;

%Y=alpha+sum fj(Xj)+eps
y=a0*ones(N,1);
for jj=1:n
    y=y+f{jj}(X(:,jj)); 
end
y = y+ normrnd(0,1,N,1);

xx=linspace(-10,10,1024);
figure
for jj=1:9
    subplot(3,3,jj);
    plot(xx,f{jj}(xx),'b')
end

%%
XX=X;
%we are stablishing the 
for ii=1:K
    XX=[XX,max(0,X-p(ii))+min(p(ii),0)];
end
%Perform regression
cvx_begin
    variables aplpha c(9*(K+1))
    minimize (1/N*sum_square(y-alpha-XX*c)+lambda*norm(c,1))
cvx_end

%plot the functions
xx=linspace(-10,10,1024);
yy=zeros(9,1024);
figure
for jj=1:9
    yy(jj,:)=c(jj)*xx;
    for ii=1:K
        yy(jj,:)=yy(jj,:)+c(ii*9+jj)*(pos(xx-p(ii))-pos(-p(ii)));
    end
    subplot(3,3,jj);
    plot(xx,yy(jj,:));
    hold on;
    plot(xx,f{jj}(xx),'r')
end

    

