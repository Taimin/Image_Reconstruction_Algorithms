close all;
clear;
%有很多像素没有值，是黑色的,而且容易出错，有很多bug，不是对所有角度都适用的
img=imread('image.jpg');
[m,n,p]=size(img);

%生成旋转矩阵
theta=pi/3;
cos_val=cos(theta);
sin_val=sin(theta);
R=[cos_val,-sin_val;sin_val,cos_val];

%将图像的坐标提取出来
row=1:m;
col=1:n;
[X,Y]=meshgrid(row,col);
x=reshape(X',1,[]);
y=reshape(Y',1,[]);
% vec_img=zeros(3,m*n);
% for i=1:3
%     vec_img(i,:)=reshape(img(:,:,i),1,[]);
% end
    
%旋转图像的坐标，得到新的坐标
Rot_cord=R*[(x-m/2-1);(y-n/2-1)];%旋转中心位于原图像的中心
Rot_img_Xcord=[floor(min(Rot_cord(1,:),[],2)),ceil(max(Rot_cord(1,:),[],2))];%图像顶点的坐标
Rot_img_Ycord=[floor(min(Rot_cord(2,:),[],2)),ceil(max(Rot_cord(2,:),[],2))];%这个坐标系不是新图像的坐标系，所以还得变换到新图像的坐标系
m1=abs(Rot_img_Xcord(2)-Rot_img_Xcord(1))+1;%新图像的行数
n1=abs(Rot_img_Ycord(2)-Rot_img_Ycord(1))+1;%新图像的列数
Rot_cord=[round(Rot_cord(1,:)+m1/2);round(Rot_cord(2,:)+n1/2)];%转换到新图像的坐标系中

%重新排列新的坐标
X=reshape(Rot_cord(1,:),m,n);
Y=reshape(Rot_cord(2,:),m,n);

Rot_img=uint8(zeros(m1,n1,3));
% Rot_img(X(1:m,1:n),Y(1:m,1:n),:)=img(1:m,1:n,:);%不能这么写
for i=1:m
    for j=1:n
        Rot_img(X(i,j),Y(i,j),:)=img(i,j,:);
    end
end

figure,imshow(img);
figure,imshow(Rot_img,[]);
