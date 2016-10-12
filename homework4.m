%minimization script for homework #4

%cvx_end

%restrictions
%[2,1]*x>=1
%[1,3]*x>=1

%x1+x2
c=[1,1];
cvx_begin
variable x(2)
minimize(c*x)
subject to
[2,1]*x>=1
[1,3]*x>=1
cvx_end

%-(x1+x2)
% c=[-1,1];
% cvx_begin
% variable x(2)
% minimize(c*x)
% subject to
% [2,1]*x>=1
% [1,3]*x>=1
% x>=[0;0]
% cvx_end
% x

% c=[1,0];
% cvx_begin
% variable x(2)
% minimize(c*x)
% subject to
% [2,1]*x>=1
% [1,3]*x>=1
% x>=[0;0]
% cvx_end
% x


% cvx_begin
% variable x(2)
% minimize(max(x))
% subject to
% [2,1]*x>=1
% [1,3]*x>=1
% x>=[0;0]
% cvx_end
% x

% cvx_begin
% variable x(2)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% [2,1]*x>=1
% [1,3]*x>=1
% x>=[0;0]
% cvx_end
% x

%------------------trying to change the constrains to feasible

%a-probado,sirve porque no podemos sacar norma mas que de funciones de una
%sola variable
% cvx_begin
% variable x(2)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% [1 2;1 -1]*x==[0;0]
% cvx_end
% x

% b-sin probar pero suena trivial
% cvx_begin
% variable x(3)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% square(square(x(1) + x(2))) <= x(1) - x(2)
% cvx_end
% x

%c-sin probar pero suena trivial
% cvx_begin
% variable x(3)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% 1/x(1)+1/x(2)<=1
%[1,1,0]>=[0,0,0]
% cvx_end
% x

% d-probado
% cvx_begin
% variables x(2) u v
% variable u 
% variable v
% minimize(x(1)^2+9*x(2)^2)
% subject to
% norm([u, v]) <= 3*x(1) + x(2) 
% max(x(1),1) <= u
% max(x(2),2) <= v
% cvx_end
% x

%e-duda de lo de geo_mean, pero probado
% cvx_begin
% variable x(3)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% geo_mean([x(1), x(2)]) >= 1
% cvx_end
% x

%f
% cvx_begin
% variable x(2)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% quad_over_lin(x(1) + x(2), sqrt(x(2))) <= x(1) - x(2) + 5
% cvx_end
% x


% cvx_begin
% variable x(3)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% x^3+y^3<=1;x>=0;y>=0
% cvx_end
% x
% 
% cvx_begin
% variable x(3)
% minimize(x(1)^2+9*x(2)^2)
% subject to
% x+z<=1+sqrt(x*y-z^2);x>=0;y>=0cvx_end
% x
% x+z<=1+sqrt(x*y-z^2);x>=0;y>=0