%rectangular picture changed to a square picture
%read an image
clear;
close all;
IM=imread('image.jpg');
IM=rgb2gray(IM);
IM=imresize(IM,0.4);
IM=im2double(IM);
IM=imcrop(IM,[1 1 255 255]);
figure,imshow(IM);

[m,n]=size(IM);

I1re=rand(m,n);
I1lm=rand(m,n);
I1x=I1re+1i*I1lm;
I1x=I1x./abs(I1x);%随机生成输入面的初始相位

I2=fft2(IM);
I2=fftshift(I2);
I2=abs(I2);

k=300;
I2q=I2.^2;
sumG=sum(sum(I2q));
sse=zeros(1,k);
l=0;

for l=1:k
        f=IM.*I1x;
        F=fft2(f);
        F=fftshift(F);
        gzf=abs(F);%得到f傅里叶变换后的g的振幅
        gx=F./gzf;       
        g2=I2.*gx;
        g2=ifftshift(g2);
        f2=ifft2(g2);
        I1x=f2./abs(f2);
        g3=gzf-I2;
        g3=g3.^2;
        sumg=sum(sum(g3));
        sse(l)=sumg/sumG;
end

I=IM.*I1x;%为得到的输入光场（包括振幅和相位）? 
 figure;
 plot(sse);
 title('sse');
