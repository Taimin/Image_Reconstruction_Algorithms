clear;
close all;
%我去，一直以为phase correlation只能做平移的图像校准，没想到也可以做旋转和缩放的校准，逆天了
fixed  = imread('cameraman.tif');
imshow(fixed);

theta = 170;
S = 2.3;
ShearY = 1.3;
tform = affine2d([S.*cosd(theta) -S.*ShearY*sind(theta) 0; S.*sind(theta) S.*cosd(theta) 0; 0 0 1]);
moving = imwarp(fixed,tform);
moving = moving + uint8(10*rand(size(moving)));
figure, imshow(moving);

tformEstimate = imregcorr(moving,fixed);
Rfixed = imref2d(size(fixed));
movingReg = imwarp(moving,tformEstimate,'OutputView',Rfixed);
figure, imshowpair(fixed,movingReg,'montage');

[optimizer, metric] = imregconfig('monomodal');
movingRegistered = imregister(moving, fixed,...
    'affine', optimizer, metric,'InitialTransformation',tformEstimate);

figure
imshowpair(fixed, movingRegistered,'montage');