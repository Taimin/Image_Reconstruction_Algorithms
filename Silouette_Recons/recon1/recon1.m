%reconstruct a sphere from edges 很不方便，一开始三维矩阵的大小没设好，重写，是错误的实现
close all;
clear
num_img=30;
X=100;
Y=100;
Z=100;
dX=X/2;
dY=Y/2;
dZ=Z/2;
prj_angle=linspace(0,2*pi,30);
recon=ones(X,Y,Z);

img=im2double(imread('circle.tif'));
img=(img==1);
[m,n]=size(img);

%create image stack
img_stack=zeros(m,n,num_img);
for z=1:num_img
    img_stack(:,:,z)=img;
end

%rotation matrix
% R_M=[1, 0, 0;1, cos(theta), sin(theta);1, -sin(theta), cos(theta)];

%first one image using visual hull reconstruction, theta==0
rowq=linspace(1,m,100);
colq=linspace(1,n,100);
[rowq,colq]=meshgrid(rowq,colq);
img1=interp2(img,rowq,colq,'nearest');%a good way to scale down an image
imshow(img1);

for z=1:Z
    recon(:,:,z)=recon(:,:,z) & img1;
end

%second image using visual hull reconstruction, 
theta=0.2167;
temp_img=zeros(Y,Z);
temp_img(1:Y,1:Z)=recon(1,1:Y,1:Z);%必须这样，要不然temp_img会是一个1*100*100的三维矩阵
temp_img=imrotate(temp_img,theta*180/pi);
[rowq_r,colq_r,q]=size(temp_img);
recon_new=zeros(X,rowq_r,colq_r);

recon_new(1,:,:)=temp_img;

% for z=1:Z
    
img1=interp2(img,rowq,colq,'nearest',1);
recon(:,:,z)=recon(:,:,z) & img1;
% end

% %third image using visual hull reconstruction, theta==pi/2
% 
% for z=1:Z
%     
%     img1=interp2(img,rowq,colq,'nearest',1);
%     recon(:,:,n)=recon(:,:,z) & img1;
% end

% for n=1:num_img
%     
% end
figure;
set(gca,'projection','perspective');
title('Demo of visual hull');
axis equal;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
hold on;
Y=ceil(sqrt(Y^2+Z^2));
[xMesh, yMesh, zMesh] = meshgrid(1:X,1:Y,1:Y);
pt = patch(isosurface(xMesh, yMesh, zMesh, recon, 0.5));
isonormals(xMesh, yMesh, zMesh, recon, pt);
set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);
camlight;
lighting gouraud;

view(-90,90);
