close all;
clear;
Image=imread('image.jpg');

%X,Y为其行列数
angle=30;
%角度任意的一个数 表示30度
pai=3.1415929657;
Angle=pai*angle/180;
%转换一下角度的表示方法。
[Y,X,Z]=size(Image);
%原图显示
subplot(2,2,1);
imshow(Image);
title('before rotation');

% 
%计算四个角点的新坐标，确定旋转后的显示区域
LeftBottom(1,1)=(Y-1)*sin(Angle);
LeftBottom(1,2)=(Y-1)*cos(Angle);

LeftTop(1,1)=0;
LeftTop(1,2)=0;

RightBottom(1,1)=(X-1)*cos(Angle)+(Y-1)*sin(Angle);
RightBottom(1,2)=-(X-1)*sin(Angle)+(Y-1)*cos(Angle);

RightTop(1,1)=(X-1)*cos(Angle);
RightTop(1,2)=-(X-1)*sin(Angle);

%计算显示区域的行列数
Xnew=max([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)])-min([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)]);
Ynew=max([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)])-min([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)]);

% 分配新显示区域矩阵
ImageNewForward=zeros(round(Ynew),round(Xnew),3)+255;
ImageNewIntersection=zeros(round(Ynew),round(Xnew),3)+255;
ImageNew1nn=zeros(round(Ynew),round(Xnew),3)+255;

%计算原图像各像素的新坐标:正向映射法
for indexX=0:(X-1)
    for indexY=0:(Y-1)
        Yn=1+round(-indexX*sin(Angle)+indexY*cos(Angle))+round(abs(min([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)])));
        Xn=round(indexX*cos(Angle)+indexY*sin(Angle))+round(abs(min([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)])))+1;
        ImageNewForward(Yn,Xn,1)=Image(indexY+1,indexX+1,1);
        ImageNewForward(Yn,Xn,2)=Image(indexY+1,indexX+1,2);
        ImageNewForward(Yn,Xn,3)=Image(indexY+1,indexX+1,3);
    end 
end

%%反向映射法
for indexY=1:round(Ynew)
    for indexX=1:round(Xnew)%这种旋转方式是错误的，没有取到真正的原图左上角
        Y1=indexY-round(abs(min([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)])));
        X1=indexX-round(abs(min([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)])));
        Yoo=X1*sin(Angle)+Y1*cos(Angle);
        Xoo=X1*cos(Angle)-Y1*sin(Angle);
        Yo=round(Yoo);
        Xo=round(Xoo);
        if 1<Xo&&Xo<X&&1<Yo&&Yo<Y
            %最近邻法
            ImageNew1nn(indexY,indexX,1)=Image(Yo,Xo,1);
            ImageNew1nn(indexY,indexX,2)=Image(Yo,Xo,2);
            ImageNew1nn(indexY,indexX,3)=Image(Yo,Xo,3);
            
            %双线性插值法
            left=floor(Xoo);
            right=ceil(Xoo);
            up=floor(Yoo);
            down=ceil(Yoo);
            
            upmid1=(1-Xoo+left)*Image(up,left,1)+(Xoo-left)*Image(up,right,1);
            downmid1=(1-Xoo+left)*Image(down,left,1)+(Xoo-left)*Image(down,right,1);
            upmid2=(1-Xoo+left)*Image(up,left,2)+(Xoo-left)*Image(up,right,2);
            downmid2=(1-Xoo+left)*Image(down,left,2)+(Xoo-left)*Image(down,right,2);
            upmid3=(1-Xoo+left)*Image(up,left,3)+(Xoo-left)*Image(up,right,3);
            downmid3=(1-Xoo+left)*Image(down,left,3)+(Xoo-left)*Image(down,right,3);
            central1=(1-Yoo+up)*upmid1+(Yoo-up)*downmid1;
            central2=(1-Yoo+up)*upmid2+(Yoo-up)*downmid2;
            central3=(1-Yoo+up)*upmid3+(Yoo-up)*downmid3;
            
            ImageNew(indexY,indexX,1)=central1;
            ImageNew(indexY,indexX,2)=central2;
            ImageNew(indexY,indexX,3)=central3;    
            
        else
             ImageNew(indexY,indexX,:)=255;
        end
    end
end

%显示
subplot(2,2,2);
ImageNewForward=uint8(ImageNewForward);
imshow(ImageNewForward);
promp=['rotation angle:' int2str(angle) 'forward mapping'];
title(promp);

subplot(2,2,3);
ImageNew1nn=uint8(ImageNew1nn);
imshow(ImageNew1nn);
promp=['rotation angle' int2str(angle) 'nearest interpolation method'];
title(promp);

subplot(2,2,4);
ImageNew=uint8(ImageNew);
imshow(ImageNew);
promp=['rotation angle' int2str(angle) 'bilinear interpolation method'];
title(promp);