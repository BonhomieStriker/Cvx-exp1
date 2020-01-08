function z = ppsnr(x,y)
x = im2double(x);
y = im2double(y);
d = x(:) - y(:);
MSE = norm(d,2)^2 / numel(x);
% MSE = immse(x,y)
z = 10 * log10( 1 / MSE);