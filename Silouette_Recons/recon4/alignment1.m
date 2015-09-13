close all;
clear;
%轮廓图像的对准, 求出图像的重心，然后直接放在图像的中心
info=imfinfo('silouette.tif');
num_images=numel(info);

image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));

for k=1:num_images
    image_stack(:,:,k)=imread('silouette.tif',k,'Info',info);
end

seg_I=uint8(zeros(info(1).Height,info(1).Width,num_images));


%首先校正第一张图像的位置，将剪影摆在中心
%求重心
x=1:info(1).Height;
y=1:info(1).Width;
[x,y]=meshgrid(y,x);
area=sum(sum(image_stack(:,:,1)));
meanx=sum(sum(double(image_stack(:,:,1)).*x))/area;
meany=sum(sum(double(image_stack(:,:,1)).*y))/area;
imshow(image_stack(:,:,1));
hold on;
plot(meanx,meany,'r+');

stats=regionprops((image_stack(:,:,1)==255),'centroid');%都可以求出重心

trans_vec=[info(1).Height/2-meanx,info(1).Width/2-meany];
I=imtranslate(image_stack(:,:,1),trans_vec,'FillValues',0);

figure,imshow(I);

%求每张图的重心，然后将每张图的中心摆在图片的中心
for k=1:num_images
    I=image_stack(:,:,k);
    area=sum(sum(I));
    meanx=sum(sum(double(I).*x))/area;
    meany=sum(sum(double(I).*y))/area;
    trans_vec=[info(1).Height/2-meanx,info(1).Width/2-meany];
    I=imtranslate(I,trans_vec,'FillValues',0);
    seg_I(:,:,k)=I;
end

implay(seg_I);

for k=1:num_images
    imwrite(seg_I(:,:,k),'silouette_aligned.tif','WriteMode','append');
end
