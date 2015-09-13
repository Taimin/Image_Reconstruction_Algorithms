%the starting phase matrix is not a random matrix but a phase matrix from
%blured picture

%rectangular picture changed to a square picture
%read an image
IM=imread('image.jpg');
IM=rgb2gray(IM);
IM=imresize(IM,0.25);
IM=im2double(IM);
IM=imcrop(IM,[1 1 170 170]);
figure,imshow(IM);

%Generate black space outside of the picture
temp=zeros(771,771);
for x=301:471
    for y=301:471
        temp(x,y)=IM(x-300,y-300);
    end
end

IM=zeros(771,771);
for x=1:771
    for y=1:771
        IM(x,y)=temp(x,y);
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

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=abs(FFT_IM);

%get the frequency domain of the blur image and get the phase angle
FFT_IM_blur=fft2(IM_blur);
FFT_IM_blur_angle=angle(FFT_IM_blur);

%Generate a new image with the Fourier frequency of the blured image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*FFT_IM_blur_angle);
IM_new=abs(ifft2(FFT_IM_new));

%Iteration between the real space and reciprocal space
Iteration=100;
for k=0:1:Iteration
    for x=1:1:771
        for y=1:1:771
            if(x<=240 || x>511 || y<=240 || y>511)
                IM_new(x,y)=0;
            end
        end
    end
    FFT_IM_new=fft2(IM_new);
    FFT_IM_new_theta=angle(FFT_IM_new);
    FFT_IM_newer=FFT_IM.*exp(1i*FFT_IM_new_theta);
    IM_newer=abs(ifft2(FFT_IM_newer));
    IM_new=IM_newer;
end

for x=1:1:771
    for y=1:1:771
        if(x<=280 || x>491 || y<=280 || y>491)
            IM_new(x,y)=0;
        end
    end
end

figure,imshow(IM_new,[]);
