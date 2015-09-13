%translation of an image
close all;
clear;
%正确的实现，实现了平移，旋转和缩放，利用的是最近邻插值
img=imread('image.jpg');
[m,n,p]=size(img);

%生成affine矩阵
theta=5*pi/3;
lambda=0.6;
shx=0.2;%注意防止A奇异，两个值不能互为倒数
shy=1/3;
T=[1 0 100;0 1 100;0 0 1];
R=[cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];
Scale=[lambda,0,0;0,lambda,0;0,0,1];
Shear=[1 shx 0;shy 1 0;0 0 1];
A=T*R*Scale*Shear;
A_inv=inv(A);

% rng shuffle;
% A=2*rand(2,3)-1;

%生成augmented coordinates
img_x=1:m;
img_y=1:n;
[img_x,img_y]=meshgrid(img_x,img_y);
img_x=reshape(img_x',1,[]);
img_y=reshape(img_y',1,[]);
img_cord=[img_x;img_y;ones(size(img_x))];

%求出仿射变换矩阵作用后新图片四个顶点的坐标
A_img_cord=A*img_cord;%求出仿射变换后图像四个顶点的坐标
% A_vertice_X=[min(A_img_cord(1,:)),min(A_img_cord(1,:));max(A_img_cord(1,:)),max(A_img_cord(1,:))];
% A_vertice_Y=[min(A_img_cord(2,:)),max(A_img_cord(2,:));min(A_img_cord(2,:)),max(A_img_cord(2,:))];
%求出图像行列数
m1=max(A_img_cord(1,:))-min(A_img_cord(1,:))+1;
n1=max(A_img_cord(2,:))-min(A_img_cord(2,:))+1;

%求出仿射变换矩阵作用后原图片四个顶点的坐标
vertice_X=[1,1,m,m];%原图片未经过仿射变换的坐标
vertice_Y=[1,n,1,n];
A_vertice_X=A(1,:)*[(vertice_X-1);(vertice_Y-1);ones(size(vertice_X))];%经过仿射变换后的坐标
A_vertice_Y=A(2,:)*[(vertice_X-1);(vertice_Y-1);ones(size(vertice_X))];


A_img=uint8(zeros(round(m1),round(n1),3));%一定钥匙uint8，要不然图像的颜色会出问题
indexX=1:round(m1);
indexY=1:round(n1);
[indexX,indexY]=meshgrid(indexX,indexY);
indexX=reshape(indexX',1,[]);
indexY=reshape(indexY',1,[]);
X1=indexX+round(min(A_vertice_X));
Y1=indexY+round(min(A_vertice_Y));
Xoo=A_inv(1,:)*[X1;Y1;ones(size(X1))];
Yoo=A_inv(2,:)*[X1;Y1;ones(size(X1))];
Xo=round(Xoo);
Yo=round(Yoo);
Xo=reshape(Xo,round(m1),round(n1));
Yo=reshape(Yo,round(m1),round(n1));

for indexX=1:round(m1)
     for indexY=1:round(n1)
        if Xo(indexX,indexY)>=1&&Xo(indexX,indexY)<=m && Yo(indexX,indexY)>=1 &&Yo(indexX,indexY)<=n %最近邻法
            A_img(indexX,indexY,:)=img(Xo(indexX,indexY),Yo(indexX,indexY),:);
        end
     end
end

imshow(A_img);

