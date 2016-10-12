%A8.5
n=4000;
k=100;
A=rand(k,n);
b=rand(k,1);
delta=1;
eta=1;

e=ones(n,1);
D=spdiags([-e 2*e -e],[-1 0 1],n,n);
D(1,1)=1;
D(n,n)=1;
I=sparse(1:n,1:n,1);

F=A'*A+eta*I+delta*D;
P=eta*I+delta*D; %P is cheap to invert since is tridiagonal
g=A'*b;

%Directly computing optimal solution
fprint('\nComputing solution directly\n');
s1=cputime;
x_gen=F\g;
s2=cputime;
fprint('Done (in %g sec)\n',s2-s1);
fprint('\nComputing solution using efficient method\n');
%x_eff=P^{-1}g-P^{-1}A'(I+AP^{-1}A')^{-1}AP^{-1}g

t1=cputime;
Z_0=P\[g A'];
z_1=Z_0(:1);
%z_2=A*z_1;
z_2=z_0(:2:k+1);
z_3=(sparse(1:k,1:k,1)+A*Z_2)\(A*z_1);
x_eff=z_1-Z_2*z_3;
t2=cputime;
fprint('Done (in % sec)\n',t2-t1);
fprint('\nrelative error=%e\n',norm(x_eff-x_gen)/norm(x_gen));


% delta=zeros(n);
% delta(1,1)=1; delta(n,n)=1; delta(1,2)=-1; delta(n,n-1)=-1;
% for i=2:n-1
%     delta(i,i-1:i+1)=[-1 2 -1];
% end
% 
% inefficient method, just solving the normal equations
% Aux=A'*A+delta+eye(n);
% tic
% x=Aux\A'*b;
% timenotefficient=toc
% 
% %
% using chosesky
% tic
% U=chol(Aux);
% y=U'\A'*b;
% xc=U\y;
% timecholesky=toc
% 
% norm(x-xc)
