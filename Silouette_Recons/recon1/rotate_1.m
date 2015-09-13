%not good enough, the rotation angle is limited. The implementation is
%wrong
close all;
clear;
img=imread('image.jpg');
[m,n,p]=size(img);

theta=2/3*pi;% theta > 0 theta < pi/2

%get the size of the box
new_img_size=ceil((m^2+n^2)^0.5);
img_rotate=uint8(zeros(new_img_size,new_img_size,3));
img_rotate_ipt=imrotate(img,theta*180/pi);

figure,imshow(img_rotate_ipt);

cos_val	= cos(theta);
sin_val	= sin(theta);

%This algorithm is too slow and the rotation direction is clockwise, not
%anti-clockwise
for x0=1:m
	for y0=1:n
		x = uint32((x0-m-1)*cos_val - (y0-n-1)*sin_val );	%ÍêÉÆÏÂ±ß(³İ¾à)
		y = uint32((x0-m-1)*sin_val + (y0-n-1)*cos_val + 0.5);
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32((x0-m-1)*cos_val - (y0-n-1)*sin_val + 0.5);	%ÍêÉÆÓÒ±ß(³İ¾à)
		y = uint32((x0-m-1)*sin_val + (y0-n-1)*cos_val );			% 
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32((x0-m-1)*cos_val - (y0-n-1)*sin_val + 0.5);	%ÍêÉÆÉÏ±ß(³İ¾à)
		y = uint32((x0-m-1)*sin_val + (y0-n-1)*cos_val - 0.5);
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32((x0-m-1)*cos_val - (y0-n-1)*sin_val );	%ÍêÉÆ×ó±ß(³İ¾à)
		y = uint32((x0-m-1)*sin_val + (y0-n-1)*cos_val -0.5);
		img_rotate(x,y,:) = img(x0,y0,:);
	end
end

figure;
imshow(img_rotate);
