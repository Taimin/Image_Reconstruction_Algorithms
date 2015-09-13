clear;
close all;
%��ȥ��һֱ��Ϊphase correlationֻ����ƽ�Ƶ�ͼ��У׼��û�뵽Ҳ��������ת�����ŵ�У׼��������
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