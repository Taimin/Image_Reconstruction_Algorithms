function [ I ] = F_GS( I1,I2,k )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   I1Ϊ����ⳡ�����
%   I2Ϊ����ⳡ�����
%   kΪ�㷨����ĵ�������
%   IΪ����Ĺⳡ��Ϊ������������λ�����

[m,n]=size(I1);
I1=double(I1);
I2=double(I2);

I1re=rand(m,n);
I1lm=rand(m,n);
I1x=I1re+i*I1lm;
I1x=I1x./abs(I1x);%�������������ĳ�ʼ��λ

I2q=I2.^2;
sumG=sum(sum(I2q));
sse=zeros(1,k);
l=0;

for l=1:k
        f=I1.*I1x;
        F=fft2(f);
        F=fftshift(F);
        gzf=abs(F);%�õ�f����Ҷ�任���g�����
        gx=F./gzf;%�õ�f����Ҷ�任���g����λ
        g2=I2.*gx;
        g2=ifftshift(g2);
        f2=ifft2(g2);
        I1x=f2./abs(f2);
        g3=gzf-I2;
        g3=g3.^2;
        sumg=sum(sum(g3));
        sse(l)=sumg/sumG;
end

I=I1.*I1x;%Ϊ�õ�������ⳡ�������������λ��
 
 figure;
 plot(sse);
 title('�������仯ͼ');

end

