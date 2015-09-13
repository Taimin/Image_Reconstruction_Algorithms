close all;
clear;
%well, better. But it can be vectorized
img=imread('image.jpg');
[m,n,p]=size(img);

theta=pi;% theta > 0 theta < pi/2

%get the size of the box
new_img_size=ceil((m^2+n^2)^0.5);
img_rotate=uint8(zeros(new_img_size,new_img_size,3));
img_rotate_ipt=imrotate(img,theta*180/pi);

figure,imshow(img_rotate_ipt);

cos_val	= cos(theta);
sin_val	= sin(theta);

for x0=1:m
	for y0=1:n
		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + new_img_size/2);	%ÍêÉÆÏÂ±ß(³İ¾à)
		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val + 0.5 + new_img_size/2);
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + 0.5 + new_img_size/2);	%ÍêÉÆÓÒ±ß(³İ¾à)
		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val + new_img_size/2);			% 
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + 0.5 + new_img_size/2);	%ÍêÉÆÉÏ±ß(³İ¾à)
		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val - 0.5 + new_img_size/2);
		img_rotate(x,y,:) = img(x0,y0,:);

		x = uint32((x0-m/2)*cos_val - (y0-n/2)*sin_val + new_img_size/2);	%ÍêÉÆ×ó±ß(³İ¾à)
		y = uint32((x0-m/2)*sin_val + (y0-n/2)*cos_val -0.5 + new_img_size/2);
		img_rotate(x,y,:) = img(x0,y0,:);
	end
end

figure;
imshow(img_rotate);