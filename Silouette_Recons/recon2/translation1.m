%translation of an image
%��ʱ��ƽ�����������и�ֵ
close all;
clear;

img=imread('image.jpg');
[m,n,p]=size(img);

%����ƽ�ƾ���,ƽ�ƶ�����Ĳ����ǼӼ�
T=[1 0 100;0 1 100;0 0 1];

%����augmented coordinates
img_x=1:m;
img_y=1:n;
[img_x,img_y]=meshgrid(img_x,img_y);
img_x=reshape(img_x',1,[]);
img_y=reshape(img_y',1,[]);
img_cord=[img_x;img_y;ones(size(img_x))];

%ƽ��img,һ������˷��͹�
T_img_cord=T*img_cord;
T_img_x=T_img_cord(1,:);
T_img_y=T_img_cord(2,:);

%�ҵ��ĸ��ǣ�����ƽ�ƺ�ͼ����ĸ�����ԭ����ϵ�е�����
vertice_X=[min(T_img_x),min(T_img_x);max(T_img_x),max(T_img_x)];
vertice_Y=[min(T_img_y),max(T_img_y);min(T_img_y),max(T_img_y)];

%�ҵ���ͼ��Ĵ�С,�������µ�ͼ��
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
