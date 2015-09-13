img=imread('digital-images-week2_quizzes-lena.gif');
img=im2double(img);%if use double, the image won't be scaled
[m,n]=size(img);

filter1=[1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];

img_filted1=imfilter(img,filter1,'replicate');

MSE1=1/m/n*sum(sum((img_filted1-img).^2));
PSNR1=10*log10(255^2/MSE1);

filter2=repmat([1/25],5,5);

img_filted2=imfilter(img,filter2,'replicate');
MSE2=1/m/n*sum(sum((img_filted2-img).^2));
PSNR2=10*log10(255^2/MSE2);