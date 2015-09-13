close all;
clear;
%http://blog.csdn.net/houston11235/article/details/6538235
%自己实现的和用imwarp不一样，原因可能是在imwarp实现中x,y坐标互换了
img=ones(480,640);
[m,n]=size(img);
figure ,imshow(img);

vertice_img=[1 1 ;480 1 ;1 640 ; 480 640];
vertice_img1=[1 1;480 1; 97 640; 384 640];

TForm=fitgeotrans(vertice_img,vertice_img1,'projective');%at least four non-collinear points were needed to infer projective transformation

x=1:m;
y=1:n;
[x,y]=meshgrid(x,y);
x=reshape(x',1,[]);
y=reshape(y',1,[]);

% img1=imwarp(img,TForm);%利用内置的函数来进行变换，最简单的方法
% figure,imshow(img1);

[p_x,p_y]=transformPointsForward(TForm,240,320);

Prj_x=TForm.T(:,1)'*[(x-1);(y-1);ones(size(x))];
Prj_y=TForm.T(:,2)'*[(x-1);(y-1);ones(size(x))];
Prj_w=TForm.T(:,3)'*[(x-1);(y-1);ones(size(x))];
Prj_x=Prj_x./Prj_w;
Prj_y=Prj_y./Prj_w;
col=round(max(Prj_x)-min(Prj_x)+1);
row=round(max(Prj_y)-min(Prj_y)+1);%新图像的行列数
Prj_img=zeros(round(col),round(row));

indexX=1:col;
indexY=1:row;
[indexX,indexY]=meshgrid(indexX,indexY);
x1=reshape(indexX',1,[]);
y1=reshape(indexY',1,[]);
x1=x1+round(min(Prj_x));
y1=y1+round(min(Prj_y));


inv_prj=inv(TForm.T);
xoo=inv_prj(:,1)'*[x1;y1;ones(size(x1))];
yoo=inv_prj(:,2)'*[x1;y1;ones(size(x1))];
woo=inv_prj(:,3)'*[x1;y1;ones(size(x1))];

xo=round(xoo./woo);
yo=round(yoo./woo);
xo=reshape(xo,col,row);
yo=reshape(yo,col,row);

for indexX=1:col
     for indexY=1:row
        if xo(indexX,indexY)>=1&&xo(indexX,indexY)<=m && yo(indexX,indexY)>=1 &&yo(indexX,indexY)<=n %最近邻法
            Prj_img(indexX,indexY)=img(xo(indexX,indexY),yo(indexX,indexY));
        end
     end
end

figure,imshow(Prj_img);