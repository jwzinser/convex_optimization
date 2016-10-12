%A11.4
% data file for circuit blending problem

n = 10; % number of variables
k = 6;  % number of designs

% component widths from known designs
% each column of W is a different design
W = [1.8381    1.5803   12.4483    4.4542    6.5637    5.8225;
     1.0196    3.0467   18.4965    3.6186    7.6979    2.3292;
     1.6813    1.9083   17.3244    4.6770    4.6581   27.0291;
     1.3795    2.6250   14.6737    4.1361    7.1610    7.5759;
     1.8318    1.4526   17.2696    3.7408    2.2107   10.3642;
     1.5028    3.0937   14.9034    4.4055    7.8582   20.5204;
     1.7095    2.1351   10.1296    4.0931    2.9001    9.9634;
     1.4289    3.5800    9.3459    3.8898    2.7663   15.1383;
     1.3046    3.5610   10.1179    4.3891    7.1302    3.8139;
     1.1897    2.7807   13.0112    4.2426    6.1611   29.6734];
 
 Wlog=log(W);

W_min = 1;
W_max = 30;

% objective values for the different designs
% entry j gives the objective for design j
P = [29.0148   46.3369  282.1749   78.5183  104.8087  253.5439];
D = [15.9522   11.5012    4.8148    8.5697    8.0870    6.0273];
A = [22.3796   38.7908  204.1574   62.5563   81.2272  200.5119];
Plog=log(P);
Dlog=log(D);
Alog=log(A);

% specifications
P_spec = 60;
D_spec = 10;
A_spec = 50;

cvx_begin
variables a(6)
find a
subject to
a>=0
a'*ones(6,1)==1
ones(10,1)<=exp(a'*Wlog')<=30*ones(10,1)
log(P_spec)>=Plog*a
log(D_spec)>=Dlog*a
log(A_spec)>=Alog*a
cvx_end

w=exp(a'*Wlog')