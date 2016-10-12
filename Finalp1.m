%FinalExam_1
n = 256;
p = 12;

randn('state', 42)
D = zeros(n,p);
for k=1:p
    D(:,k) = cos(pi*k*(2*(1:n)'-1)/(2*n));
end
w = randn(p,1);
x_orig = D*w;

l = zeros(n,1);
l(x_orig >= 1) = 1;
l(x_orig <= -1) = -1;


%SOLUTION

cvx_begin
    variables x_est(n) w(p)
    minimize (norm(x_est))
    subject to
    x_est(find(l==-1))<=-1
    x_est(find(l==1))>=1
    -1<=x_est(find(l==0))<=1
    x_est==D*w
cvx_end
%%
hold off
aux=[1:256];
plot(aux,x_orig,'blue')
hold on
plot(aux,x_est,'red')
legend('xest(red)','xorig(blue)')
title('Signal reconstruction from level information')




