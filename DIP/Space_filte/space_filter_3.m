%Gaussian filter
img=imread('Fig0441(a)(characters_test_pattern).tif');
figure,imshow(img);
[m,n]=size(img);

img_fft=fft2(img);
%log_img_fft=log(1+img_fft);
%figure,imshow(abs(log_img_fft),[]);

sigma=15;
H=zeros(m,n);
for u=1:m
    for v=1:n
        D=sqrt((u-floor(m/2)-1)^2+(v-floor(n/2)-1)^2);
        H(u,v)=exp(-D^2/2/sigma^2);
    end
end

img_fft=fftshift(img_fft);
img_blur_fft=img_fft.*H;
img_blur_fft=ifftshift(img_blur_fft);
img_blur=ifft2(img_blur_fft);
figure,imshow(img_blur,[]);