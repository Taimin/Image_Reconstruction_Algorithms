%generate frequency domain filter using space domain filter
%the result is successful
img=imread('Fig0526(a)(original_DIP).tif');
% img=rgb2gray(img);
[m,n]=size(img);
p=2*m;
q=2*n;

motion_blur=fspecial('motion',50,-45);

img_fft=fft2(img,p,q);%paddled with zeros
%img_fft=fftshift(img_fft);
motion_blur_fft=fft2(motion_blur,p,q);
img_blur_fft=img_fft.*motion_blur_fft;

img_blur=ifft2(img_blur_fft);

img_blur_new=zeros(m,n);
for a=19:m+18
    for b=19:n+18
        img_blur_new(a-18,b-18)=img_blur(a,b);
    end
end

figure,imshow(img_blur_new,[]);