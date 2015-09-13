%wrong result the same as Wiener 4
img=imread('lena_color.jpg');
img=rgb2gray(img);
[m,n]=size(img);
figure,imshow(img);
p=2*m;
q=2*n;

T=1;
a=0.1;
b=0.1;
motion_blur_fft=zeros(m,n);
for u=1:p
    for v=1:q
        motion_blur_fft(u,v)=T/(pi*(u*a+v*b))*sin(pi*(u*a+v*b))*exp(-1i*pi*(u*a+v*b));
    end
end

img_fft=fft2(img,p,q);
img_blur_fft=img_fft.*motion_blur_fft;
img_blur=ifft2(img_blur_fft);

figure,imshow(img_blur,[]);