close all;
clear;
%先对图像做好预处理，然后再进行分割
info=imfinfo('Garnet_img_8.tif');
num_images=numel(info);

image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));

for k=1:num_images
    image_stack(:,:,k)=imread('Garnet_img_8.tif',k,'Info',info);
end

seg_I=uint8(zeros(info(1).Height,info(1).Width,num_images));


for k=1:num_images
    I=image_stack(:,:,k);
    I=adapthisteq(I);
    se=strel('disk',10);
    

    seg_I(:,:,k)=I;
end

implay(seg_I);