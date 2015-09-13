close all;
clear;
%�кܶ�����û��ֵ���Ǻ�ɫ��,�������׳����кܶ�bug�����Ƕ����нǶȶ����õ�
img=imread('image.jpg');
[m,n,p]=size(img);

%������ת����
theta=pi/3;
cos_val=cos(theta);
sin_val=sin(theta);
R=[cos_val,-sin_val;sin_val,cos_val];

%��ͼ���������ȡ����
row=1:m;
col=1:n;
[X,Y]=meshgrid(row,col);
x=reshape(X',1,[]);
y=reshape(Y',1,[]);
% vec_img=zeros(3,m*n);
% for i=1:3
%     vec_img(i,:)=reshape(img(:,:,i),1,[]);
% end
    
%��תͼ������꣬�õ��µ�����
Rot_cord=R*[(x-m/2-1);(y-n/2-1)];%��ת����λ��ԭͼ�������
Rot_img_Xcord=[floor(min(Rot_cord(1,:),[],2)),ceil(max(Rot_cord(1,:),[],2))];%ͼ�񶥵������
Rot_img_Ycord=[floor(min(Rot_cord(2,:),[],2)),ceil(max(Rot_cord(2,:),[],2))];%�������ϵ������ͼ�������ϵ�����Ի��ñ任����ͼ�������ϵ
m1=abs(Rot_img_Xcord(2)-Rot_img_Xcord(1))+1;%��ͼ�������
n1=abs(Rot_img_Ycord(2)-Rot_img_Ycord(1))+1;%��ͼ�������
Rot_cord=[round(Rot_cord(1,:)+m1/2);round(Rot_cord(2,:)+n1/2)];%ת������ͼ�������ϵ��

%���������µ�����
X=reshape(Rot_cord(1,:),m,n);
Y=reshape(Rot_cord(2,:),m,n);

Rot_img=uint8(zeros(m1,n1,3));
% Rot_img(X(1:m,1:n),Y(1:m,1:n),:)=img(1:m,1:n,:);%������ôд
for i=1:m
    for j=1:n
        Rot_img(X(i,j),Y(i,j),:)=img(i,j,:);
    end
end

figure,imshow(img);
figure,imshow(Rot_img,[]);
