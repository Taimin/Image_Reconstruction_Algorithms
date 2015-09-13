close all;
clear;

%����һ��image stack
info=imfinfo('Garnet_img_8.tif');
num_images=numel(info);
image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));
for k=1:num_images
    image_stack(:,:,k)=imread('Garnet_img_8.tif',k,'Info',info);
end

%�ȴ���һ��ͼ
I=image_stack(:,:,1);
I_edge=edge(I,'canny',0.25);

% B=[0 1 0; 1 1 1; 0 1 0];
A=strel('disk',4);
B=strel('disk',3);
I_edge=imdilate(I_edge,B);%�Ա�Ե��������

I_edge=imfill(I_edge,'holes');%����

I_edge=imerode(I_edge,B);%��ʴ����������Χ��������ȥ��
I_edge=imerode(I_edge,B);
I_edge=imerode(I_edge,A);
I_edge=imerode(I_edge,B);


I_edge=imdilate(I_edge,B);
I_edge=imdilate(I_edge,A);
I_edge=imdilate(I_edge,B);

figure,imshow(I);
figure,imshow(I_edge);