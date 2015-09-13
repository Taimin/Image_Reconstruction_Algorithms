close all;
clear;
img=imread('Fig0526(a)(original_DIP).tif');
%img=rgb2gray(img);
% img=ones(688,688);%全白图测试
[m,n]=size(img);
%figure,imshow(img);
p=2*m;%如果p=m,q=n的话，会出现aliasing
q=2*n;

%比较一下看看结果是不是一样的，果然是一样的，不过自己实现的速度慢了很多
% motion=fspecial('motion',50*sqrt(2),-45);
% img_b=imfilter(img,motion);
% figure,imshow(img_b)

T=1;
a=50;%用全白图测试，刚好左上角顶点刚好移动到x=50和y=50上
b=50;%在这个实现中a,b一定要都大于零
% a=0.1;%和我猜测的一样，如果表达式中c中没有除上p和q则移动的位置是a*p和b*q
% b=0.1;

motion_blur_fft=zeros(p,q);%改变频谱的大小
for u=1:p
    for v=1:q
        c=(u-floor(p/2)-1)*a/p+(v-floor(q/2)-1)*b/q;
%         c=(u-floor(p/2)-1)*a+(v-floor(q/2)-1)*b;
        if  c== 0
             motion_blur_fft(u,v)=T;
        else
            motion_blur_fft(u,v)=T/(pi*c)*sin(pi*c)*exp(-1i*pi*c);
%             motion_blur_fft(u,v)=T/p*(1-exp(-1i*2*pi*c))/(1-exp(-1i*2*pi*c/p));%当p比较大的时候，就相当于上面的式子，一样的，不要用这一个，因为不知道把时间分成多少份
        end
            
    end
end

fft_img=fft2(img,p,q);
fft_img=fftshift(fft_img);
fft_img_blur=fft_img.*motion_blur_fft;
img_blur=ifft2(ifftshift(fft_img_blur));

img_blur=img_blur(floor(a/2)+1:floor(a/2)+m,floor(b/2)+1:floor(b/2)+n);

%给图加噪声
mean=0;
variance=0.01;
%求出噪声的功率谱

img_blur=imnoise(uint8(img_blur),'gaussian',mean,variance);
imshow(img_blur,[]);


%维纳滤波
% img_filtered=wiener2(img_blur,[5,5]);%这个只能消除噪声，不能校正图像，还是得自己写才行

figure,imshow(img_filtered);


