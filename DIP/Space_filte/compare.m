%comparision between filter made by freqz2 and fft2
%h=fspecial('gaussian',[3 3],1);

img=imread('Fig0441(a)(characters_test_pattern).tif');
figure,imshow(img);
[m,n]=size(img);

img_fft=fft2(img);
img_fft=fftshift(img_fft);

h=fspecial('sobel');
H=freqz2(h,[m n]);
abs_H=abs(H);
%figure,imshow(abs_H,[]);

h_fft=fft2(h,m,n);
h_fft=fftshift(h_fft);
abs_h_fft=abs(h_fft);
%figure,imshow(abs_h_fft,[]);

img1_fft=img_fft.*H;
img2_fft=img_fft.*h_fft;

img1_fft=ifftshift(img1_fft);
img2_fft=ifftshift(img2_fft);

img1=ifft2(img1_fft);
img2=ifft2(img2_fft);

figure,imshow(img1,[]);
figure,imshow(img2,[]);

img3=imfilter(img,h,'circular','same','corr');%produce an image which is very different from convolution result
figure,imshow(img3,[]);

img4=conv2(img,h,'same');%the same result as img2 688+3-1
figure,imshow(img4,[]);