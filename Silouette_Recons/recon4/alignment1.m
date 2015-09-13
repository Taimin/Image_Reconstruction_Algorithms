close all;
clear;
%����ͼ��Ķ�׼, ���ͼ������ģ�Ȼ��ֱ�ӷ���ͼ�������
info=imfinfo('silouette.tif');
num_images=numel(info);

image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));

for k=1:num_images
    image_stack(:,:,k)=imread('silouette.tif',k,'Info',info);
end

seg_I=uint8(zeros(info(1).Height,info(1).Width,num_images));


%����У����һ��ͼ���λ�ã�����Ӱ��������
%������
x=1:info(1).Height;
y=1:info(1).Width;
[x,y]=meshgrid(y,x);
area=sum(sum(image_stack(:,:,1)));
meanx=sum(sum(double(image_stack(:,:,1)).*x))/area;
meany=sum(sum(double(image_stack(:,:,1)).*y))/area;
imshow(image_stack(:,:,1));
hold on;
plot(meanx,meany,'r+');

stats=regionprops((image_stack(:,:,1)==255),'centroid');%�������������

trans_vec=[info(1).Height/2-meanx,info(1).Width/2-meany];
I=imtranslate(image_stack(:,:,1),trans_vec,'FillValues',0);

figure,imshow(I);

%��ÿ��ͼ�����ģ�Ȼ��ÿ��ͼ�����İ���ͼƬ������
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
