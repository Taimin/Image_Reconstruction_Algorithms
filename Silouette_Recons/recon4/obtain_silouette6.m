close all;
clear;
%对已经人工寻找边界的图像求轮廓
info=imfinfo('Garnet_img_8_edge.tif');
num_images=numel(info);

image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));

for k=1:num_images
    image_stack(:,:,k)=imread('Garnet_img_8_edge.tif',k,'Info',info);
end

seg_I=uint8(zeros(info(1).Height,info(1).Width,num_images));


for k=1:num_images
    I=image_stack(:,:,k);
    I=(I>250);
    se=strel('disk',10);
    I=imdilate(I,se);
    I=imfill(I,'holes');
    
    I=imerode(I,se);
    
    I=imdilate(I,se);
    I=imerode(I,se);

    
    seg_I(:,:,k)=I;
end

seg_I=seg_I*255;

implay(seg_I);

for k=1:num_images
    imwrite(seg_I(:,:,k),'silouette.tif','WriteMode','append');
end