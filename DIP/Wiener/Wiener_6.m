close all;
clear;
img=imread('Fig0526(a)(original_DIP).tif');
%img=rgb2gray(img);
% img=ones(688,688);%ȫ��ͼ����
[m,n]=size(img);
%figure,imshow(img);
p=2*m;%���p=m,q=n�Ļ��������aliasing
q=2*n;

%�Ƚ�һ�¿�������ǲ���һ���ģ���Ȼ��һ���ģ������Լ�ʵ�ֵ��ٶ����˺ܶ�
% motion=fspecial('motion',50*sqrt(2),-45);
% img_b=imfilter(img,motion);
% figure,imshow(img_b)

T=1;
a=50;%��ȫ��ͼ���ԣ��պ����ϽǶ���պ��ƶ���x=50��y=50��
b=50;%�����ʵ����a,bһ��Ҫ��������
% a=0.1;%���Ҳ²��һ����������ʽ��c��û�г���p��q���ƶ���λ����a*p��b*q
% b=0.1;

motion_blur_fft=zeros(p,q);%�ı�Ƶ�׵Ĵ�С
for u=1:p
    for v=1:q
        c=(u-floor(p/2)-1)*a/p+(v-floor(q/2)-1)*b/q;
%         c=(u-floor(p/2)-1)*a+(v-floor(q/2)-1)*b;
        if  c== 0
             motion_blur_fft(u,v)=T;
        else
            motion_blur_fft(u,v)=T/(pi*c)*sin(pi*c)*exp(-1i*pi*c);
%             motion_blur_fft(u,v)=T/p*(1-exp(-1i*2*pi*c))/(1-exp(-1i*2*pi*c/p));%��p�Ƚϴ��ʱ�򣬾��൱�������ʽ�ӣ�һ���ģ���Ҫ����һ������Ϊ��֪����ʱ��ֳɶ��ٷ�
        end
            
    end
end

fft_img=fft2(img,p,q);
fft_img=fftshift(fft_img);
fft_img_blur=fft_img.*motion_blur_fft;
img_blur=ifft2(ifftshift(fft_img_blur));

img_blur=img_blur(floor(a/2)+1:floor(a/2)+m,floor(b/2)+1:floor(b/2)+n);

%��ͼ������
mean=0;
variance=0.01;
%��������Ĺ�����

img_blur=imnoise(uint8(img_blur),'gaussian',mean,variance);
imshow(img_blur,[]);


%ά���˲�
% img_filtered=wiener2(img_blur,[5,5]);%���ֻ����������������У��ͼ�񣬻��ǵ��Լ�д����

figure,imshow(img_filtered);


