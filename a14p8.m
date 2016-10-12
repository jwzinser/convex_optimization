h = 1;
g = 0.1;
m = 10;
Fmax = 10;
p0 = [50,50,100]';
v0 = [-10,0,-10]';
alpha = 0.5;
gamma = 1;
K = 35;

% use the following code to plot your trajectories
% plot the glide cone (don't modify)
% -------------------------------------------------------
 x = linspace(-40,55,30); y = linspace(0,55,30);
 [X,Y] = meshgrid(x,y);
 Z = alpha*sqrt(X.^2+Y.^2);
 figure; colormap autumn; surf(X,Y,Z);
 axis([-40,55,0,55,0,105]);
 grid on; hold on;

% INSERT YOUR VARIABLES HERE:
%%
%minimize the fuel
cvx_begin
variables f(3,K) p(3,K+1) v(3,K+1)
minimize sum(norms(f))
subject to 
p(:,1)==p0;
v(:,1)==v0;
p(:,2:K+1)==p(:,1:K)+(v(:,1:K)+v(:,2:K+1))/2
v(:,2:K+1)==v(:,1:K)+(1/m)*f-repmat([0;0;1],1,K);
p(:,K+1)==0;
v(:,K+1)==0;
norms(f)<=Fmax;
p(3,:)>=alpha*norms(p(1:2,:));

cvx_end
min_fuel=cvx_optval*gamma*h;
p_minf=p; v_minf=v; f_minf=f;

%Find maximum K
%will use linear search but bisection is faster


%-------------------------------------------------------
 plot3(p(1,:),p(2,:),p(3,:),'b','linewidth',1.5);
 quiver3(p(1,1:K),p(2,1:K),p(3,1:K),...
         f(1,:),f(2,:),f(3,:),0.3,'k','linewidth',1.5);