close all;
clear;

numCamera = 18;
volumeX = 64;
volumeY = 150;
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
% figure;
% set(gca,'projection','perspective');
% title('Demo of visual hull');
% axis equal;
% grid on;
% xlabel('x');
% ylabel('y');
% zlabel('z');
% hold on;
% [xMesh,yMesh,zMesh] = meshgrid((1:volumeY)-dY,(1:volumeX)-dX,(1:volumeZ)-dZ);



thresh = 110;
scale = 1/16;
volume = ones(volumeX,volumeY,volumeZ);
interp=zeros(volumeX,volumeY,volumeZ);

[x,y,z1]=meshgrid((1:volumeY)-dY,(1:volumeX)-dX,(1:volumeZ)-dZ);

for i=1:numCamera
    img = SImage{i} >= thresh;
    P = PMatrix{i};
    
    for z=1:volumeZ
        
        Z=(P(3,1).*x(:,:,z)+P(3,2).*y(:,:,z)+P(3,3).*z1(:,:,z))./5+P(3,4).*ones(volumeX,volumeY);
        X=(P(1,1)*x(:,:,z)+P(1,2)*y(:,:,z)+P(1,3)*z1(:,:,z))/5+P(1,4)*ones(volumeX,volumeY);
        Y=(P(2,1)*x(:,:,z)+P(2,2)*y(:,:,z)+P(2,3)*z1(:,:,z))/5+P(2,4)*ones(volumeX,volumeY);
        u=X./Z;
        v=Y./Z;
        volume(:,:,z) = volume(:,:,z) & interp2(img, u,v,'*nearest', 1);
    end

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
[xMesh,yMesh,zMesh] = meshgrid(1:volumeY,1:volumeX,1:volumeZ);
pt = patch(isosurface(xMesh, yMesh, zMesh, volume, 0.5));
isonormals(xMesh, yMesh, zMesh, volume, pt);
set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);
camlight;
lighting gouraud;

view(-90,90);