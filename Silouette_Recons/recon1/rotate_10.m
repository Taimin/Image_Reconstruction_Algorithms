%先生成旋转过后图像的坐标矩阵，然后反旋转，得到具有小数点的坐标矩阵，通过双线性插值求出小数点坐标上的数值
close all;
clear;
%额，稍微快了一点点吧，最近邻法，因为得到旋转前坐标用了round，所以称作最近邻法
%由于旋转后矩形区域中的坐标都取到了，所以，不用担心正旋转法的缺像素的问题

img=imread('image.jpg');
[m,n,p]=size(img);

%生成旋转矩阵
theta=2*pi/3;
cos_val=cos(theta);
sin_val=sin(theta);
R=[cos_val,-sin_val;sin_val,cos_val];
R_inv=[cos_val,sin_val;-sin_val,cos_val];

%以原图的左上角（1,1）为旋转中心，求出旋转后图像四个顶点的坐标
vertice_X=[1 1 m m];
vertice_Y=[1 n 1 n];
Rot_vertice_X=R(1,:)*[(vertice_X-1);(vertice_Y-1)];
Rot_vertice_Y=R(2,:)*[(vertice_X-1);(vertice_Y-1)];

%求出四个顶点所围成的矩形的坐标
%先求出所得到新图像的行列数
m1=max(Rot_vertice_X)-min(Rot_vertice_X)+1;
n1=max(Rot_vertice_Y)-min(Rot_vertice_Y)+1;

Rot_img=uint8(zeros(round(m1),round(n1),3));

% for indexX=1:round(m1)%速度太慢，加速，向量化
%     for indexY=1:round(n1)
%         X1=indexX-round(abs(min(Rot_vertice_X)));%得到新图像的坐标
%         Y1=indexY-round(abs(min(Rot_vertice_Y)));
%         Xoo=R_inv(1,:)*[X1;Y1];
%         Yoo=R_inv(2,:)*[X1;Y1];
%         Xo=round(Xoo);
%         Yo=round(Yoo);
%         if 1<Xo&&Xo<m&&1<Yo&&Yo<n%最近邻法
%             Rot_img(indexX,indexY,:)=img(Xo,Yo,:);
%         end
% 
%     end
% end
indexX=1:round(m1);
indexY=1:round(n1);
[indexX,indexY]=meshgrid(indexX,indexY);
indexX=reshape(indexX',1,[]);
indexY=reshape(indexY',1,[]);
% X1=indexX-ceil(abs(m1/2));%得到新图像的坐标
% Y1=indexY-ceil(abs(n1/2));
X1=indexX+round(min(Rot_vertice_X));%需要做坐标变换，使旋转的轴从旋转后图片的左上角变换到旋转前图片的左上角
Y1=indexY+round(min(Rot_vertice_Y));%旋转变换后，原图左上角的点位于新坐标系中的位置可以用画图来确定
Xoo=R_inv(1,:)*[X1;Y1];
Yoo=R_inv(2,:)*[X1;Y1];
Xo=round(Xoo);
Yo=round(Yoo);
% Xo=find(Xo>1 & Xo<m);
% Yo=find(Yo>1 & Yo<n);
Xo=reshape(Xo,round(m1),round(n1));
Yo=reshape(Yo,round(m1),round(n1));
for indexX=1:round(m1)
     for indexY=1:round(n1)
        if Xo(indexX,indexY)>=1&&Xo(indexX,indexY)<=m && Yo(indexX,indexY)>=1 &&Yo(indexX,indexY)<=n %最近邻法
            Rot_img(indexX,indexY,:)=img(Xo(indexX,indexY),Yo(indexX,indexY),:);
        end
     end
end

imshow(Rot_img);


