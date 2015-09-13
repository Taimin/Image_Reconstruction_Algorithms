function [ I ] = F_GS( I1,I2,k )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   I1为输入光场的振幅
%   I2为输出光场的振幅
%   k为算法程序的迭代次数
%   I为输出的光场，为复数，包括相位和振幅

[m,n]=size(I1);
I1=double(I1);
I2=double(I2);

I1re=rand(m,n);
I1lm=rand(m,n);
I1x=I1re+i*I1lm;
I1x=I1x./abs(I1x);%随机生成输入面的初始相位

I2q=I2.^2;
sumG=sum(sum(I2q));
sse=zeros(1,k);
l=0;

for l=1:k
        f=I1.*I1x;
        F=fft2(f);
        F=fftshift(F);
        gzf=abs(F);%得到f傅里叶变换后的g的振幅
        gx=F./gzf;%得到f傅里叶变换后的g的相位
        g2=I2.*gx;
        g2=ifftshift(g2);
        f2=ifft2(g2);
        I1x=f2./abs(f2);
        g3=gzf-I2;
        g3=g3.^2;
        sumg=sum(sum(g3));
        sse(l)=sumg/sumG;
end

I=I1.*I1x;%为得到的输入光场（包括振幅和相位）
 
 figure;
 plot(sse);
 title('均方误差变化图');

end

