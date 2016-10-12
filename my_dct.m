function d = my_dct(x)
%DCT  Discrete cosine transform.
%
%   Y = DCT(X) returns the discrete cosine transform of X.
%   The vector Y is the same size as X and contains the
%   discrete cosine transform coefficients.
% 
%   If X is a matrix, the DCT operation is applied to each
%   column.  This transform can be inverted using IDCT.

if nargin == 0,
    error('Not enough input arguments.')
end

if isempty(x)
   d = [];
   return
end

% If input is a vector, make it a column:
do_trans = (size(x,1) == 1);
if do_trans, x = x(:); end

[n,m] = size(x);

% Compute weights to multiply DFT coefficients
ww = (exp(-1i*(0:n-1)*pi/(2*n))/sqrt(2*n)).';
ww(1) = ww(1) / sqrt(2);

if rem(n,2)==1 || ~isreal(x), % odd case
  % Form intermediate even-symmetric matrix
  y = zeros(2*n,m);
  y(1:n,:) = x;
  y(n+1:2*n,:) = flipud(x);
  
  % Compute the FFT and keep the appropriate portion:
  yy = fft(y);  
  yy = yy(1:n,:);

else % even case
  % Re-order the elements of the columns of x
  y = [ x(1:2:n,:); x(n:-2:2,:) ];
  yy = fft(y);  
  ww = 2*ww;  % Double the weights for even-length case  
end

% Multiply FFT by weights:
d = ww(:,ones(1,m)) .* yy;

if isreal(x), d = real(d); end
if do_trans, d = d.'; end