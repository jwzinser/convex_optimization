%A.1
A=[1 2;1 -4;5 76];
b=[-2 -3 1]';
cvx_begin
variable x(2)
dual variables lambda
minimize (quad_form(x,[1 -.5;-.5 2])-x(1))
subject to
lambda: A*x<=b
cvx_end
p_star=cvx_optval;
%Solution from the 
%%
%to fill in the table of the deltas changes
delta=[0 -.1 .1];
patable=[];
for i=delta
    for j=delta
        pred=p_star-lambda'*[i;j;0];
        cvx_begin
        variable x(2)
        minimize (quad_form(x,[1 -.5;-.5 2])-x(1))
        subject to
        A*x<=b+[i;j;0]
        cvx_end
        pexact=cvx_optval
        patable=[patable;i j pred pexact];
    end
end
    
