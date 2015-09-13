%ideal space filter(another implementation)
img=imread('Fig0441(a)(characters_test_pattern).tif');
figure,imshow(img);
[m,n]=size(img);

img_fft=fft2(img);
%log_img_fft=log(1+img_fft);
%figure,imshow(abs(log_img_fft),[]);

H=zeros(m,n);
for u=1:m
    for v=1:n
        D=sqrt((u-floor(m/2)-1)^2+(v-floor(n/2)-1)^2);
        if D<=30
            H(u,v)=1;
        else
            H(u,v)=0;
        end
    end
end

H=ifftshift(H);
img_blur_fft=img_fft.*H;
img_blur=ifft2(img_blur_fft);
figure,imshow(img_blur,[]);