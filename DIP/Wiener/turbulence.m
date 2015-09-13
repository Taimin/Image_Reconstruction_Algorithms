%the effect is affected by the boundary
img=imread('lena_color.jpg');
img=rgb2gray(img);
%img=padarray(img,[512 512],'post');%add zeros to an image or vector
[m,n]=size(img);
figure,imshow(img);

turb_blur=zeros(m,n);
k=0.0025;
for u=1:m
    for v=1:n
        turb_blur(u,v)=exp(-k.*(u.^2+v.^2).^(5/6));
    end
end

fft_img=fft2(img,m,n);
img_blur_fft=fft_img.*turb_blur;
img_blur=ifft2(img_blur_fft);%img_blur is a complex matrix

figure,imshow(img_blur,[]);