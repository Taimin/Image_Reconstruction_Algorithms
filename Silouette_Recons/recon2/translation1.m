%translation of an image
%此时，平移向量不能有负值
close all;
clear;

img=imread('image.jpg');
[m,n,p]=size(img);

%生成平移矩阵,平移对坐标的操作是加减
T=[1 0 100;0 1 100;0 0 1];

%生成augmented coordinates
img_x=1:m;
img_y=1:n;
[img_x,img_y]=meshgrid(img_x,img_y);
img_x=reshape(img_x',1,[]);
img_y=reshape(img_y',1,[]);
img_cord=[img_x;img_y;ones(size(img_x))];

%平移img,一个矩阵乘法就够
T_img_cord=T*img_cord;
T_img_x=T_img_cord(1,:);
T_img_y=T_img_cord(2,:);

%找到四个角，这是平移后图像的四个角在原坐标系中的坐标
vertice_X=[min(T_img_x),min(T_img_x);max(T_img_x),max(T_img_x)];
vertice_Y=[min(T_img_y),max(T_img_y);min(T_img_y),max(T_img_y)];

%找到新图像的大小,并生成新的图像
m1=vertice_X(2,2);
n1=vertice_Y(2,2);
T_img=uint8(zeros(m1,n1,3));

T_img_x=reshape(T_img_x,m,n);
T_img_y=reshape(T_img_y,m,n);



for i=1:m
    for j=1:n
        T_img(T_img_x(i,j),T_img_y(i,j),:)=img(i,j,:);
    end
end

imshow(T_img);
