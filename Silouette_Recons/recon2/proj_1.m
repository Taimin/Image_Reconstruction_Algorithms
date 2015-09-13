%matlab有函数可以做坐标变换，记录一下
close all;
clear;
A = imread('image.jpg');
theta = 10;
tform = projective2d([cosd(theta) -sind(theta) 0.001; sind(theta) cosd(theta) 0.001; 0 0 1]);
outputImage = imwarp(A,tform);
figure, imshow(outputImage);

I = imread('pout.tif');
J = imtranslate(I,[5.3, -10.1],'FillValues',255);
figure, imshow(J);

s = load('mri');
mriVolume = squeeze(s.D);
sizeIn = size(mriVolume);
hFigOriginal = figure;
hAxOriginal  = axes;
slice(double(mriVolume),sizeIn(2)/2,sizeIn(1)/2,sizeIn(3)/2);
grid on, shading interp, colormap gray;

