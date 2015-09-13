close all;
clear;
%The implementation is fine and right. But not good enough because there
%are too many blank space
img=imread('image.jpg');
[m,n,p]=size(img);

theta=2*pi;% theta > 0 theta < pi/2

%get the size of the box
new_img_size=ceil((m^2+n^2)^0.5);
img_rotate=uint8(zeros(2*new_img_size,2*new_img_size,3));
img_rotate_ipt=imrotate(img,theta*180/pi);

figure,imshow(img_rotate_ipt);

cos_val	= cos(theta);
sin_val	= sin(theta);

for x0=1:m
	for y0=1:n
		x = uint32(x0*cos_val - y0*sin_val + new_img_size);	%ÍêÉÆÏÂ±ß(³İ¾à)
		y = uint32(x0*sin_val + y0*cos_val + 0.5 + new_img_size);
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32(x0*cos_val - y0*sin_val + 0.5 + new_img_size);	%ÍêÉÆÓÒ±ß(³İ¾à)
		y = uint32(x0*sin_val + y0*cos_val + new_img_size);			% 
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32(x0*cos_val - y0*sin_val + 0.5 + new_img_size);	%ÍêÉÆÉÏ±ß(³İ¾à)
		y = uint32(x0*sin_val + y0*cos_val - 0.5 + new_img_size);
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32(x0*cos_val - y0*sin_val + new_img_size);	%ÍêÉÆ×ó±ß(³İ¾à)
		y = uint32(x0*sin_val + y0*cos_val -0.5 + new_img_size);
		img_rotate(x,y,:) = img(x0,y0,:);
	end
end

figure;
imshow(img_rotate);