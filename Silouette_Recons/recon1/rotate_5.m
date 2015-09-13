%To deal with the black area out side of the image, we can crop it after we
%rotate the image. Or we can calculate the size of the image and then
%rotate. Sounds like a better idea.
%But it is too slow, with so many useless loops. Interpolation will perform
%better

close all;
clear;

img=imread('image.jpg');
[m,n,p]=size(img);

theta=4/3*pi;
cos_val	= cos(theta);
sin_val	= sin(theta);

%get the size of the box
new_img_size=ceil((m^2+n^2)^0.5);
% img_rotate=uint8(zeros(new_img_size,new_img_size,3));
vertice_x=[1 1;m m];
vertice_y=[1 n;1 n];
vertice_x1 = round((vertice_x-m/2)*cos_val - (vertice_y-n/2)*sin_val + new_img_size/2);
vertice_y1 = round((vertice_x-m/2)*sin_val + (vertice_y-n/2)*cos_val + new_img_size/2);
vertice_x1_r=reshape(vertice_x1,4,1);
vertice_y1_r=reshape(vertice_y1,4,1);
vertice_x1_min=min(vertice_x1_r);
vertice_x1_max=max(vertice_x1_r);
vertice_y1_min=min(vertice_y1_r);
vertice_y1_max=max(vertice_y1_r);
a=vertice_x1_max-vertice_x1_min+4;
b=vertice_y1_max-vertice_y1_min+4;
img_rotate=uint8(zeros(a,b,3));

img_rotate_ipt=imrotate(img,theta*180/pi);
figure,imshow(img_rotate_ipt);

x0=(1:m)';
y0=(1:n);
x1=repmat(x0,1,n);
y1=repmat(y0,m,1);
% [x1,y1]=meshgrid(x0,y0);

%rotate the image, the center of the rotation is the center of the picture
x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + a/2);	
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val + b/2);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);
    end
end


x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + 0.5 + a/2);	%ÕÍ…∆”“±ﬂ(≥›æ‡)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val + b/2);			% 
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);%Right
    end
end

x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + 0.5 + a/2);	%ÕÍ…∆…œ±ﬂ(≥›æ‡)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val - 0.5 + b/2);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);
    end
end

x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + a/2);	%ÕÍ…∆◊Û±ﬂ(≥›æ‡)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val -0.5 + b/2);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);
    end
end

figure;
imshow(img_rotate);