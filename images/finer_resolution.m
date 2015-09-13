IM=zeros(600,600);

%Generate an image and show it
for k=0:2:19
    for j=0:2:19
        IM(100+20*k:120+20*k,100+20*j:120+20*j)=1;
    end
end
figure,imshow(IM);

%Blur Kernel, Gaussian Blur,Generate a kernel for image blur
ksize = 102;
blur = zeros(ksize);
s = 6;
m = ksize/2;
[X, Y] = meshgrid(1:ksize);
blur = (1/(2*pi*s^2))*exp(-((X-m).^2 + (Y-m).^2)/(2*s^2));

%Blur the image and show it
IM_blur=conv2(IM,blur,'same');
figure,imshow(IM_blur);

%Generate randon angles
fai=2*pi*rand(600,600,'double');

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
FFT_IM=abs(FFT_IM);
FFT_IM_log=log(FFT_IM);
%imshow(FFT_IM_log,[]);
%selected_pixel=FFT_IM(293:307,293:207);
%selected_pixel_DFI=DFI(293:307,293:207);

%get the frequency domain of the blur image
FFT_IM_blur=fft2(IM_blur);
FFT_IM_blur=fftshift(FFT_IM_blur);
FFT_IM_blur=abs(FFT_IM_blur);
FFT_IM_blur_log=log(FFT_IM_blur);
%imshow(FFT_IM_blur_log,[]);

%Generate a new image with the Fourier frequency of the blured image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*fai);
IM_new=abs(ifft2(FFT_IM_new));
%imshow(IM_new,[]);

%Iteration between the real space and reciprocal space
Iteration=100;
for k=0:1:Iteration
    for x=1:1:600
        for y=1:1:600
            if(x<100 || x> 480 || y<100 || y>480)
                IM_new(x,y)=0;
            end
        end
    end
    FFT_IM_new=fft2(IM_new);
    FFT_IM_new=fftshift(FFT_IM_new);
    FFT_IM_new_theta=angle(FFT_IM_new);
    FFT_IM_newer=FFT_IM.*exp(1i*FFT_IM_new_theta);
    IM_newer=abs(ifft2(FFT_IM_newer));
    IM_new=IM_newer;
end

   for x=1:1:600
        for y=1:1:600
            if(x<100 || x> 480 || y<100 || y>480)
                IM_new(x,y)=0;
            end
        end
    end

figure,imshow(IM_new,[]);


