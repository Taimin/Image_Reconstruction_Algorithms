img=imread('lena_color.jpg');
img=rgb2gray(img);
[m,n]=size(img);
p = 2*m;  
q = 2*n; 

turb_blur=zeros(p,q);
k=0.0025;
for u=1:p
    for v=1:q
        turb_blur(u,v)=exp(-k.*(u.^2+v.^2).^(5/6));%can not use this one
    end
end

img_fft=fft2(img,p,q);

img_blur_fft=img_fft.*turb_blur;

img_blur=ifft2(img_blur_fft);%complex number matrix, the same effect as turbulence.m

imshow(img_blur,[]);