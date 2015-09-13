%translation of an image
%ƽ�ƿ����и�ֵ�ˣ������޷���ʾ��ƽ�Ƶ�Ч����
close all;
clear;

img=imread('image.jpg');
[m,n,p]=size(img);

%����ƽ�ƾ���,ƽ�ƶ�����Ĳ����ǼӼ�
T=[1 0 100;0 1 100;0 0 1];
T_inv=inv(T);

%�ҵ��ĸ��ǣ�����ƽ�ƺ�ͼ����ĸ�����ԭ����ϵ�е�����
vertice_X=[1,1,m,m];
vertice_Y=[1,n,1,n];
T_vertice_X=T(1,:)*[(vertice_X-1);(vertice_Y-1);ones(1,4)];
T_vertice_Y=T(2,:)*[(vertice_X-1);(vertice_Y-1);ones(1,4)];
m1=max(T_vertice_X)-min(T_vertice_X)+1;
n1=max(T_vertice_Y)-min(T_vertice_Y)+1;
T_img=uint8(zeros(m1,n1,3));

indexX=1:round(m1);
indexY=1:round(n1);
[indexX,indexY]=meshgrid(indexX,indexY);
indexX=reshape(indexX',1,[]);
indexY=reshape(indexY',1,[]);
X1=indexX+round(min(T_vertice_X));%�ҵ�ԭͼƬ�����Ͻǣ����ܽ��з��任����
Y1=indexY+round(min(T_vertice_Y));
Xoo=T_inv(1,:)*[X1;Y1;ones(size(X1))];
Yoo=T_inv(2,:)*[X1;Y1;ones(size(X1))];
Xo=round(Xoo);
Yo=round(Yoo);
Xo=reshape(Xo,round(m1),round(n1));
Yo=reshape(Yo,round(m1),round(n1));

for indexX=1:round(m1)
    for indexY=1:round(n1)
        T_img(indexX,indexY,:)=img(Xo(indexX,indexY),Yo(indexX,indexY),:);
    end
end

imshow(T_img);