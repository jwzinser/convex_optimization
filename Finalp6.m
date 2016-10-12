%Final Exam 6
% Optimal module placement

n = 5; % number of modules 

% areas
a = [1;
    2.2;
    4.1;
    1.3;
    5.5];

% aspect ratio parameters
r = [0.9;
    2.5;
    0.3;
    4.0;
    0.5];

s = [1.1;
    3.5;
    0.4;
    4.3;
    0.7];

%%
%Solution to the problem
cvx_begin
    variables h(5) w(5) wt ht
    minimize (log(wt)+log(ht))
    lw=log(x)
    lh=log(h)
    subject to
    a==lw+lh
    log(r)<=log(h)-log(w)<=log(s)
    wt==max(w(3),w(4)+w(5))+max(w(1),w(2))
    ht==max(h(3)+max(h(4),h(5)),h(1)+h(2))
cvx_end
    
    




% % this code plots the layout
% colors = {'r','g','c','b','m'};
% figure(1); clf; hold on
% axis([-0.5 W+0.5 -0.5 H+0.5]);
% for i=1:n
%     rec = rectangle('Position', [x(i) y(i) w(i) h(i)]);
%     set(rec,'facecolor',colors{i})
%     t = text( x(i)+ w(i)/2, y(i) + h(i)/2,[ 'M' num2str(i)]);
%     set(t,'fontsize',14,'HorizontalAlignment','center');
% end
% rectangle('Position', [0 0 W H],'linewidth',2)
% hold off
% axis image;