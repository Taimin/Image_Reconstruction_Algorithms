close all;
clear
%����ͼ���ع�
info=imfinfo('silouette_aligned.tif');
num_img=numel(info);
X=100;
Y=100;
Z=100;
dX=X/2;
dY=Y/2;
dZ=Z/2;
theta=pi/num_img;
recon=ones(X,Y,Z);

img=im2double(imread('circle.tif'));
img=(img==1);
[m,n]=size(img);
rowq=linspace(1,m,100);
colq=linspace(1,n,100);
[rowq,colq]=meshgrid(rowq,colq);

%create image stack
img_stack=zeros(m,n,num_img);
for z=1:num_img
    img_stack(:,:,z)=img;
end

for i=1:num_img
    %һЩ��ʼ������
    img1=img_stack(:,:,i);%��img_stack��ȡ��һ��ͼƬ
    
    
    %����ά������ȡ������ͼƬ���õ���ת����ͼƬ�Ĵ�С,Ŀ���ǵõ���ά����Ĵ�С
    recon_tmp=zeros(X,Y,Z);%�������ά������ͼƬ��visual hull�ع�
    
    for x=1:X
        temp_img=zeros(Y,Z);
        temp_img(:,:)=recon(x,:,:);
        temp_img=imrotate(temp_img,theta*180/pi,'crop');
        recon_tmp(x,:,:)=temp_img;
    end
    
    img2=interp2(img1,rowq',colq','nearest');
    
    for z=1:Z
        recon_tmp(:,:,z)=recon_tmp(:,:,z) & img2;
    end
    recon=recon_tmp;
end
    
%��ʾ��visualization
figure;
set(gca,'projection','perspective');
title('Demo of visual hull');
axis equal;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
hold on;
%Y=ceil(sqrt(Y^2+Z^2));
[xMesh, yMesh, zMesh] = meshgrid(1:Y,1:X,1:Z);
pt = patch(isosurface(xMesh, yMesh, zMesh, recon, 0.5));
isonormals(xMesh, yMesh, zMesh, recon, pt);
set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);
camlight;
lighting gouraud;

view(-90,90);