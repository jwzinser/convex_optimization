%  x=zeros(4,1);
%  phi_des=1/4*ones(4,1);
%  maxiter=100;
%  alpha=.01;
%  beta=.5;
%  gradtol=.001;
%  for iter=1:maxiter
%      fx=.5*x'*Sigma*x-sum(log(x)/n);
%      grad=x'*Sigma-(1./x)'/n;
%      grad=grad';
%      if norm(grad)<=gradtol, break,end;
%      v=-grad;
%      fprime=grad'*v;
%      t=1;
%      while(.5*(x+t*v)'*Sigma*(x+t*v)-sum(log(x+t*v)/n)>fx+alpha*t*fprime)
%          t=beta*t;
%      end
%      x=x+t*v;
%  end;
