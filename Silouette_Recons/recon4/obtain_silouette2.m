close all;
clear;
%��ͬ��ͼƬ��Ҫ�ı���������������Ҫ�ԣ����ܶ�����ͬһ������
%����ı���threshold�������ǲ�����Ϊ���������븯ʴ�Ĳ���ҲҪ���Ÿı�
%����һ��image stack
info=imfinfo('Garnet_img_8.tif');
num_images=numel(info);
image_stack=uint8(zeros(info(1).Height,info(1).Width,num_images));
for k=1:num_images
    image_stack(:,:,k)=imread('Garnet_img_8.tif',k,'Info',info);
end

I_silouette=logical(zeros(info(1).Height,info(1).Width,num_images));
thresh=zeros(num_images,1);

for i=1:num_images
    I=image_stack(:,:,i);
    
    flag=0;
    while flag~=1
        thresh(i)=input('Please input the threshhold (greater 0 and smaller than 1): ');
        err=1;
        while err~=0 %��ֹ�û��Ƿ�����
            if thresh(i)>=0 && thresh(i)<=1
                err=0;
            else
                thresh(i)=input('Invalid! Please input a number greater 0 and smaller than 1!');
            end
        end
        
        I_edge=edge(I,'canny',thresh(i));
        imshow(I_edge);
        
        flag=input('Is the result acceptable? 1 for YES, 0 for NO');
        err=1;
        while err~=0%��ֹ�û��Ƿ�����
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
    I_silouette(:,:,i)=I_edge;
end

implay(I_silouette);