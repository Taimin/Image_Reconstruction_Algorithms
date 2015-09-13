close all;

numCamera = 18;
volumeX = 480;
volumeY = 640;
volumeZ = 480;
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
scale = 1;
volume = ones(volumeX,volumeY,volumeZ);

for i = 1:numCamera
    img = SImage{i} >= thresh;
    P = PMatrix{i};
    
    x1 = P(1,1)*scale*((1:volumeX)-dX);
    y1 = P(2,1)*scale*((1:volumeX)-dX);
    z1 = P(3,1)*scale*((1:volumeX)-dX);
    x2 = P(1,2)*scale*((1:volumeY)-dY);
    y2 = P(2,2)*scale*((1:volumeY)-dY);
    z2 = P(3,2)*scale*((1:volumeY)-dY);

    for Z = 1:volumeZ
        p = P(:,3:4)*[scale*(Z-dZ) 1]';
        z = z1'*ones(1,volumeY) +  ones(volumeX,1)*z2 + p(3);
        x = (x1'*ones(1,volumeY) +  ones(volumeX,1)*x2 + p(1)) ./ z;
        y = (y1'*ones(1,volumeY) +  ones(volumeX,1)*y2 + p(2)) ./ z;
        volume(:,:,Z) = volume(:,:,Z) & interp2(img, x, y,'*nearest', 1);
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
[xMesh yMesh zMesh] = meshgrid(1:volumeY,1:volumeX,1:volumeZ);
pt = patch(isosurface(xMesh, yMesh, zMesh, volume, 0.5));
isonormals(xMesh, yMesh, zMesh, volume, pt);
set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);
camlight;
lighting gouraud;

view(-90,90);
