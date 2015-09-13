%wrong result, I think it changed the phase angle of the FFT image greatly
img=imread('Fig0526(a)(original_DIP).tif');
%img=rgb2gray(img);
[m,n]=size(img);
%imshow(img);
p=2*m;
q=2*n;

T=1;
a=0.1;
b=0.1;

motion_blur_fft=zeros(m,n);
for u=1:m
    for v=1:n
        c=(u-1)*a+(v-1)*b;
        if  c== 0
            motion_blur_fft(u,v)=T;
        else
            motion_blur_fft(u,v)=T/(pi*c)*sin(pi*c)*exp(-1i*pi*c);
        end
            
    end
end

img_fft=fft2(img);
img_blur_fft=img_fft.*motion_blur_fft;
img_blur=ifft2(img_blur_fft);


figure,imshow(img_blur,[]);