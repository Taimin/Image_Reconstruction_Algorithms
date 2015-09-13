img=imread('../Wiener/Fig0526(a)(original_DIP).tif');
figure,imshow(img);
[m,n]=size(img);
p=2*m;
q=2*n;

img_fft=fft2(img,p,q);
img_fft=fftshift(img_fft);

h=fspecial('motion',50,-45);
[a,b]=size(h);
H=freqz2(h,[p q]);
%abs_H=abs(H);
%figure,imshow(abs_H,[]);

h_fft=fft2(h,p,q);
h_fft=fftshift(h_fft);
%abs_h_fft=abs(h_fft);

img1_fft=img_fft.*H;
img2_fft=img_fft.*h_fft;

img1_fft=ifftshift(img1_fft);
img2_fft=ifftshift(img2_fft);

img1=ifft2(img1_fft);
img2=ifft2(img2_fft);
%crop
img1=img1(1:m,1:n);
img2=img2(floor(a/2):m+floor(a/2)-1,floor(b/2):n+floor(b/2)-1);

figure,imshow(img1,[]);
figure,imshow(img2,[]);