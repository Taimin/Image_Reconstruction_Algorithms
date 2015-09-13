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

k=300;

%�������������ĳ�ʼ��λ
I1x=2*pi*rand(256,256)-pi;

I2=fft2(IM);
I2=fftshift(I2);
I2=abs(I2);

I2q=I2.^2;
sumG=sum(sum(I2q));
sse=zeros(1,k);
l=0;

for l=1:2
        f=IM.*exp(1i*I1x);
        F=fft2(f);
        F=fftshift(F);
        gzf=abs(F);%�õ�f����Ҷ�任���g�����
        gx=F./gzf;
        g2=I2.*gx;
        g2=ifftshift(g2);
        f2=ifft2(g2);
        I1x=angle(f2);
        g3=gzf-I2;%�Ƚ�ÿ��ѭ���еõ���fftƵ��ǿ�Ⱥͳ�ʼƵ��ǿ��֮��Ĳ�ֵ
        g3=g3.^2;
        sumg=sum(sum(g3));
        sse(l)=sumg/sumG;
end

I=IM.*exp(1i*I1x);%Ϊ�õ�������ⳡ�������������λ��
 figure;
 plot(sse);
 title('sse');
