%Exercise A4.21
%%
rand('seed',0);
A = rand(30,10);
b = rand(30,1);
c_nom = 1+rand(10,1);
g=[1.25*c_nom;-.75*c_nom;1.1*sum(c_nom);-.9*sum(c_nom)];
F=zeros(22,10);
F(1:10,1:10)=eye(n);
F(11:20,1:10)=-eye(n);
F(21,:)=ones(1,10);
F(22,:)=-1*ones(1,10);
%%
%Robust optimization
cvx_begin
variables x_rob(10) lambda(22)
minimize (g'*lambda)
subject to
A*x_rob>=b
F'*lambda-x_rob==0
lambda>=0
x>=0

cvx_end
robust=cvx_optval

%Nominal cost problem
%%
%nominal sin tomar en cuenta lo aleatorio de c
cvx_begin
variables x_nom(10)
minimize (c_nom'*x_nom)
subject to
x_nom>=0
A*x_nom>=b
cvx_end
nominal=cvx_optval
%%
%worst case cost of x_nom, pensando que toma c como dado, pero c se eleva
%mucho
cvx_begin
variables c_wc(10)
minimize(c_wc'*x_nom)
subject to
F*c_wc<=g
cvx_end
worst=cvx_optval





