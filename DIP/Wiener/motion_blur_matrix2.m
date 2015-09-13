%用插值法实现任意角度的运动模糊卷积核的生成
close all;
clear;
theta=pi/4;%counter-clockwise is the positive direction
num_pixel=69;
line=1:num_pixel;
x=-(line-1)*sin(theta);%精确的直线xy坐标,以0 0为中心旋转
y=(line-1)*cos(theta);

m=round(max(x)-min(x)+1);
n=round(max(y)-min(y)+1);

i=1:m;%新建立一个坐标系
j=1:n;
%把精确直线的xy坐标变换到这个坐标系中
x=x-min(x)+1;
y=y-min(y)+1;

