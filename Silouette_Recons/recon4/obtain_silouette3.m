close all;
clear;
%试用active contour做image segmentation
%有问题，而且参数需要调整，很难弄
info=imfinfo('Garnet_img_8.tif');
% num_images=numel(info);
num_images=10;
image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));
for k=1:num_images
    image_stack(:,:,k)=imread('Garnet_img_8.tif',k,'Info',info);
end

I_silouette= false(info(1).Height,info(1).Width,num_images);
bw= false(info(1).Height,info(1).Width,num_images);
% mask= false(info(1).Height,info(1).Width,num_images);
load mask.mat

maxIterations = 40; 

for i=1:num_images
    I=image_stack(:,:,i);
    imshow(I);
%     mask(:,:,i)=roipoly;
    bw(:,:,i) = activecontour(I, mask(:,:,i), maxIterations, 'Chan-Vese');
end

for i=1:num_images
    I=image_stack(:,:,i);
    imshow(I);
%     mask(:,:,i)=roipoly;
    bw(:,:,i) = activecontour(I, bw(:,:,i), 70, 'edge');
end

% imshow(I_filled,[]);
% imshow(bw);
implay(bw);