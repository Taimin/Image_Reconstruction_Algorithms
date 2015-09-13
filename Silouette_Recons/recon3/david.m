% Volumetric Visual Hull Construction
% by Li Guan, Oct 27th 2007

clear, close all;

numCamera = 18;
volumeX = 64;
volumeY = 128;
volumeZ = 64;
dX = volumeX/2;
dY = volumeY/2;
dZ = volumeZ/2;
visualHullSamplingRate = 0.1;
silhouetteThreshold = 200;

% load silhouette images and projection matrices
for i=1:numCamera
    if(i<=10)
        PMatrix{i} = load(['./smallDavid/david_0' int2str(i-1) '.pa']);
        SImage{i} = rgb2gray(imread(['./smallDavid/david_0' int2str(i-1) '.jpg']));
    else        
        PMatrix{i} = load(['./smallDavid/david_' int2str(i-1) '.pa']);
        SImage{i} = rgb2gray(imread(['./smallDavid/david_' int2str(i-1) '.jpg']));
    end;
end;

% visual hull computation
% you should provide the code here

thresh = 110;
scale = 1/16;
volume = ones(volumeX,volumeY,volumeZ);

% for i = 1:1
%     img = SImage{i} >= thresh;
%     P = PMatrix{i};
% 
%     for Z=1:volumeZ
%         
%     end
% end

%reconstruct the first image
img=SImage{1}>=thresh;
P=PMatrix{i};
[m,n]=size(img);
x=linspace(1,m,volumeX);
y=linspace(1,n,volumeY);
z=linspace(1,volumeZ,volumeZ);
[x,y,z]=meshgrid(x,y,z);
x=reshape(x',1,[]);
y=reshape(y',1,[]);
z=reshape(z',1,[]);
homo_cord=P*[x;y;z;ones(size(x))];
x=homo_cord(1,:)./homo_cord(3,:);
y=homo_cord(2,:)./homo_cord(3,:);
x=reshape(x,volumeX,volumeY,volumeZ);
y=reshape(y,volumeX,volumeY,volumeZ);

for Z=1:volumeZ
    
    volume(:,:,Z) = volume(:,:,Z) & interp2(img, squeeze(x(:,:,Z)), squeeze(y(:,:,Z)),'*nearest', 1);
end

% display result
figure;
set(gca,'projection','perspective');
title('Demo of visual hull');
axis equal;
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
hold on;
[xMesh yMesh zMesh] = meshgrid(1:volumeY,1:volumeX,1:volumeZ);
pt = patch(isosurface(xMesh, yMesh, zMesh, volume, 0.5));
isonormals(xMesh, yMesh, zMesh, volume, pt);
set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);
camlight;
lighting gouraud;

view(-90,90);
