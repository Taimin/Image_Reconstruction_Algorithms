close all;
clear;
%this implementation is fine. But still there is black box outside of the
%picture
img=imread('image.jpg');
[m,n,p]=size(img);

theta=pi/2;% theta > 0 theta < pi/2

%get the size of the box
new_img_size=ceil((m^2+n^2)^0.5);
img_rotate=uint8(zeros(new_img_size,new_img_size,3));
img_rotate_ipt=imrotate(img,theta*180/pi);

figure,imshow(img_rotate_ipt);

cos_val	= cos(theta);
sin_val	= sin(theta);

% for x0=1:m
% 	for y0=1:n
% 		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + new_img_size/2);	%ÍêÉÆÏÂ±ß(³İ¾à)
% 		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val + 0.5 + new_img_size/2);
% 		img_rotate(x,y,:) = img(x0,y0,:);
% 
% 		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + 0.5 + new_img_size/2);	%ÍêÉÆÓÒ±ß(³İ¾à)
% 		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val + new_img_size/2);			% 
% 		img_rotate(x,y,:) = img(x0,y0,:);
% 
% 		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + 0.5 + new_img_size/2);	%ÍêÉÆÉÏ±ß(³İ¾à)
% 		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val - 0.5 + new_img_size/2);
% 		img_rotate(x,y,:) = img(x0,y0,:);
% 
% 		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + new_img_size/2);	%ÍêÉÆ×ó±ß(³İ¾à)
% 		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val -0.5 + new_img_size/2);
% 		img_rotate(x,y,:) = img(x0,y0,:);
% 	end
% end

x0=(1:m)';
y0=(1:n);
x1=repmat(x0,1,n);
y1=repmat(y0,m,1);
% [x1,y1]=meshgrid(x0,y0);

x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + new_img_size/2);	%ÍêÉÆÏÂ±ß(³İ¾à)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val + 0.5 + new_img_size/2);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);
    end
end
% img_rotate(x(x0,y0),y(x0,y0),:)=img(x1(x0,y0),y1(x0,y0),:);%wrong
% implementation, not advisable


x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + 0.5 + new_img_size/2);	%ÍêÉÆÓÒ±ß(³İ¾à)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val + new_img_size/2);			% 
% for i=1:n
%     img_rotate(x(:,1),y(1),:)=img(:,i,:);%wrong, not one-by-one
%     correspondence
% end
% img_rotate(y(1,:),x(:,1),:)=img(:,:,:);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);%Right
    end
end

x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + 0.5 + new_img_size/2);	%ÍêÉÆÉÏ±ß(³İ¾à)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val - 0.5 + new_img_size/2);
% for i=1:n
%     img_rotate(x(:,1),y(1),:)=img(:,i,:);
% end
% img_rotate(y(1,:),x(:,1),:)=img(:,:,:);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);
    end
end

x = uint32((x1-m/2)*cos_val - (y1-n/2)*sin_val + new_img_size/2);	%ÍêÉÆ×ó±ß(³İ¾à)
y = uint32((x1-m/2)*sin_val + (y1-n/2)*cos_val -0.5 + new_img_size/2);
% for i=1:n
%     img_rotate(x(:,1),y(1),:)=img(:,i,:);
% end
% img_rotate(y(1,:),x(:,1),:)=img(:,:,:);
for i=1:m
    for j=1:n
        img_rotate(x(i,j),y(i,j),:)=img(i,j,:);
    end
end

figure;
imshow(img_rotate);