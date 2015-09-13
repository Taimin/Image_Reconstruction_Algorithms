%Wrong result because you use continuous integration to calculate discrete
%function. Also, this method will create divide zero result in the
%motion_blur_fft matrix
[m,n]=size(img);

T=1;
a=0;
b=0.05;

% Set up range of variables.
u = 0:(m - 1);
v = 0:(n - 1);

% Compute the indices for use in meshgrid.
idx = find(u > m/2);
u(idx) = u(idx) - m;
idy = find(v > n/2);
v(idy) = v(idy) - n;

% Compute the meshgrid arrays.
[V, U] = meshgrid(v, u);

c=U.*a+V.*b;

motion_blur_fft=T/pi./c.*sin(pi.*c).*exp(-1i*pi.*c);



motion_blur=ifft(ifftshift(motion_blur_fft));