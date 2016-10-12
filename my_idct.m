function x = my_idct(d)
%IDCT Inverse discrete cosine transform.
%
%   X = IDCT(Y) inverts the DCT transform, returning the
%   original vector if Y was obtained using Y = DCT(X).
%
%   If Y is a matrix, the IDCT operation is applied to
%   each column.

if nargin == 0,
    error('Not enough input arguments.')
end

if isempty(d),
   x = [];
   return
end

% If input is a vector, make it a column:
do_trans = (size(d,1) == 1);
if do_trans, d = d(:); end
   
[n,m] = size(d);

% Compute weights
ww = sqrt(2*n) * exp(1i*(0:n-1)*pi/(2*n)).';

if rem(n,2)==1 || ~isreal(d), % odd case
  % Form intermediate even-symmetric matrix.
  ww(1) = ww(1) * sqrt(2);
  W = ww(:,ones(1,m));
  yy = zeros(2*n,m);
  yy(1:n,:) = W.*d;
  yy(n+2:2*n,:) = -1i*W(2:n,:).*flipud(d(2:n,:));
  
  y = ifft(yy);

  % Extract inverse DCT
  x = y(1:n,:);

else % even case
  % Compute precorrection factor
  ww(1) = ww(1)/sqrt(2);
  W = ww(:,ones(1,m));
  yy = W.*d;

  % Compute x tilde using equation (5.93) in Jain
  y = ifft(yy);
  
  % Re-order elements of each column according to equations (5.93) and
  % (5.94) in Jain
  x = zeros(n,m);
  x(1:2:n,:) = y(1:n/2,:);
  x(2:2:n,:) = y(n:-1:n/2+1,:);
end

if isreal(d), x = real(x); end
if do_trans, x = x.'; end