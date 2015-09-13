%rectangular picture changed to a square picture
%read an image
IM=imread('image.jpg');
IM=rgb2gray(IM);
IM=imresize(IM,0.4);
IM=im2double(IM);
IM=imcrop(IM,[1 1 255 255]);
figure,imshow(IM);

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
%angle_exact=angle(FFT_IM);
FFT_IM=abs(FFT_IM);

%generate random phase in real space
rand_theta=2*pi*rand(256,256)-pi;

%generate the first complex image using random phase
IM_1=IM*exp(1i*rand_theta);
FFT_IM_1=fft2(IM_1);
FFT_IM_1=fftshift(FFT_IM_1);
FFT_IM_1_theta=angle(FFT_IM_1);
FFT_IM_2=FFT_IM*exp(1i*FFT_IM_1_theta);
FFT_IM_2=ifftshift(FFT_IM_2);
IM_2=ifft2(FFT_IM_2);
IM_2_theta=angle(IM_2);

iteration=3;
for k=1:1:iteration
    IM_1=IM.*exp(1i*IM_2_theta);
    FFT_IM_1=fft2(IM_1);
    FFT_IM_1=fftshift(FFT_IM_1);
    FFT_IM_1_theta=angle(FFT_IM_1);
    FFT_IM_2=FFT_IM.*exp(1i*FFT_IM_1_theta);
    FFT_IM_2=ifftshift(FFT_IM_2);
    IM_2=ifft2(FFT_IM_2);
    IM_2_theta=angle(IM_2);
end

figure,imshow(abs(IM_1),[]);