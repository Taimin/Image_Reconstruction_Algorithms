%�ò�ֵ��ʵ������Ƕȵ��˶�ģ������˵�����
close all;
clear;
theta=pi/4;%counter-clockwise is the positive direction
num_pixel=69;
line=1:num_pixel;
x=-(line-1)*sin(theta);%��ȷ��ֱ��xy����,��0 0Ϊ������ת
y=(line-1)*cos(theta);

m=round(max(x)-min(x)+1);
n=round(max(y)-min(y)+1);

i=1:m;%�½���һ������ϵ
j=1:n;
%�Ѿ�ȷֱ�ߵ�xy����任���������ϵ��
x=x-min(x)+1;
y=y-min(y)+1;

