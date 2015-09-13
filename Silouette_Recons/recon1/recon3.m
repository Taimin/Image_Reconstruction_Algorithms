close all;
clear
%多张图的重构，这样子也是错误的，因为旋转的不应该是img1
num_img=6;
X=100;
Y=100;
Z=100;
dX=X/2;
dY=Y/2;
dZ=Z/2;
prj_angle=linspace(0,pi,num_img);
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
    %一些初始化工作
    img1=img_stack(:,:,i);%从img_stack里取出一张图片
    theta=prj_angle(i);
    temp_img=imrotate(img1,theta*180/pi);
    [m1,n1]=size(temp_img);
    recon_tmp=zeros(X,m1,n1);%用这个三维矩阵单张图片的visual hull重构
    recon_tmp(1,:,:)=temp_img;
    
    for x=1:X
        temp_img=zeros(Y,Z);
        temp_img(1:Y,1:Z)=recon(x,1:Y,1:Z);
        temp_img=imrotate(temp_img,theta*180/pi);
        recon_tmp(x,:,:)=temp_img;
    end
    
    img2=interp2(img1,rowq,colq,'nearest');
    img2=padarray(img2,[0 floor((m1-100)/2)],'pre');
    img2=padarray(img2,[0 ceil((m1-100)/2)],'post');
    subplot(5,6,i);
    imshow(img2);
    
    for z=1:n1
        recon_tmp(:,:,z)=recon_tmp(:,:,z) & img2;
    end
    recon=recon_tmp;
end
    
%显示，visualization
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
[X,Y,Z]=size(recon);
[xMesh, yMesh, zMesh] = meshgrid(1:Y,1:X,1:Z);
pt = patch(isosurface(xMesh, yMesh, zMesh, recon, 0.5));
isonormals(xMesh, yMesh, zMesh, recon, pt);
set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);
camlight;
lighting gouraud;

view(-90,90);