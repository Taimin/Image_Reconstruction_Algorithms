close all;
clear;
%试用一下最大类间方差法
info=imfinfo('Garnet_img_8.tif');
num_images=numel(info);
% num_images=10;
image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));

for k=1:num_images
    image_stack(:,:,k)=imread('Garnet_img_8.tif',k,'Info',info);
end

BW=false(info(1).Height,info(1).Width);
I_BW=false(info(1).Height,info(1).Width,num_images);
seg_I=zeros(info(1).Height,info(1).Width,num_images);
% divide=4;效果比较差
% 
% for k=1:num_images
%     I=image_stack(:,:,k);
%     for x=1:floor(info(1).Height/divide)
%         for y=1:floor(info(1).Width/divide)
%             level=graythresh(I(1+divide*(x-1):divide*x,1+divide*(y-1):divide*y));
%             BW(1+divide*(x-1):divide*x,1+divide*(y-1):divide*y)=im2bw(image_stack(1+divide*(x-1):divide*x,1+divide*(y-1):divide*y),level);
%         end
%     end
%     I_BW(:,:,k)=BW;
% end

level=9;%先用multithresh做预处理
for k=1:num_images
    I=image_stack(:,:,k);
    thresh=multithresh(I,level);
    seg_I(:,:,k) = imquantize(I,thresh);
end
seg_I=seg_I/(level+1);
seg_I=uint8(seg_I*255);


se=strel('disk',2);
for k=1:num_images
    I=image_stack(:,:,k);
    I=imdilate(I,se);
    I=imdilate(I,se);
    I=imerode(I,se);
    I=imerode(I,se);
    seg_I(:,:,k) = I;
end

thresh=zeros(1,num_images);
for k=1:num_images
    I=seg_I(:,:,k);
    
    flag=0;
    while flag~=1
        thresh(k)=input('Please input the threshhold (greater 0 and smaller than 1): ');
        err=1;
        while err~=0 %防止用户非法输入
            if thresh(k)>=0 && thresh(k)<=1
                err=0;
            else
                thresh(k)=input('Invalid! Please input a number greater 0 and smaller than 1!');
            end
        end
        
        I_edge=edge(I,'canny',thresh(k));
        imshow(I_edge);
        
        flag=input('Is the result acceptable? 1 for YES, 0 for NO');
        err=1;
        while err~=0%防止用户非法输入
            if flag==1
                err=0;
                flag=1;
            elseif flag==0
                err=0;
            else
                flag=input('Invalid! Please input another value: ');
            end
        end
        
    end
    A=strel('disk',4);
    B=strel('disk',3);
    I_edge=imdilate(I_edge,B);%对边缘进行膨胀

    I_edge=imfill(I_edge,'holes');%填充孔

    I_edge=imerode(I_edge,B);%腐蚀操作，将周围其他杂质去掉
    I_edge=imerode(I_edge,B);
    I_edge=imerode(I_edge,A);
    I_edge=imerode(I_edge,B);


    I_edge=imdilate(I_edge,B);
    I_edge=imdilate(I_edge,A);
    I_edge=imdilate(I_edge,B);
    seg_I(:,:,k)=I_edge;
end

seg_I=seg_I*255;

implay(seg_I);