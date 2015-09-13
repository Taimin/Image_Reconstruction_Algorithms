%比较一下直接用imfilter，fspecial函数和利用公式的差别
close all;
clear;
img=imread('Fig0526(a)(original_DIP).tif');
%img=rgb2gray(img);
[m,n]=size(img);
%figure,imshow(img);
p=2*m;
q=2*n;

motion_blur=fspecial('motion',ceil(2*68.8*sqrt(2)),-45);
img_blur=imfilter(img,motion_blur,'conv');
%img_blur=conv2(img,motion_blur,'same');%This two statements has the same
%effect as the last statement

figure,imshow(img_blur,[]);

T=1;
a=0.1;
b=0.1;

motion_blur_fft=zeros(p,q);
for u=1:p
    for v=1:q
        c=((u-floor(p/2)-1)*a+(v-floor(q/2)-1)*b)/p;
        if  c== 0
            motion_blur_fft(u,v)=T;
        else
%             motion_blur_fft(u,v)=T/(pi*c)*sin(pi*c)*exp(-1i*pi*c);
            motion_blur_fft(u,v)=T*(1-exp(-1i*2*pi*c))/(1-exp(-1i*2*pi*c));
        end
            
    end
end
img1=padarray(img,[688 688],'post');
fft_img1=fftshift(fft2(img1));%效果同fft2(img,p,q),其中,img是大小为m n的图片,p q的大小为2m 2n
fft_img1_blur=fft_img1.*motion_blur_fft;
img1_blur=ifft2(ifftshift(fft_img1_blur));
img1_blur=img1_blur(69:m+69,69:69+n);
figure,imshow(img1_blur,[]);