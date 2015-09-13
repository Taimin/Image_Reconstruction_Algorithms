%comparision between regular filter and wiener filter
%can not do this because the zero point of the motion degradation function
%is inf, which is bad

img=imread('Fig0526(a)(original_DIP).tif');
%img=rgb2gray(img);
[m,n]=size(img);
figure,imshow(img);
p=2*m;
q=2*n;

%add noise
%noise_var=0.1;
%img_noise=imnoise(img,'gaussian',0,noise_var);

%degradation function using in-built function
%motion_blur=fspecial('motion',20,45);
%img_blur=conv2(double(img_noise),motion_blur,'same');
%img_filter=imfilter(img,motion_blur);

%self-written degradation function 
T=1;
a=0.05;
b=0.05;

motion_blur_fft=zeros(p,q);
for u=1:p
    for v=1:q
        c=(u-floor(p/2)-1)*a+(v-floor(q/2)-1)*b;
        if  c== 0
            motion_blur_fft(u,v)=T;
        else
            motion_blur_fft(u,v)=T/p*(1-exp(-1i*2*pi*c))/(1-exp(-1i*2*pi*c/p));
        end
            
    end
end

img_fft=fft2(img,p,q);
img_fft=fftshift(img_fft);
img_blur_fft=img_fft.*motion_blur_fft;
img_blur_fft=ifftshift(img_blur_fft);
img_blur=ifft2(img_blur_fft);

% img_blur=img_blur(1:m,26:26+n);
figure,imshow(img_blur,[]);
%figure,imshow(img_filter,[]);


%direct inverse filter
