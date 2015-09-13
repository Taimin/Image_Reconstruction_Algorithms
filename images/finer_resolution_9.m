%Cut the picture to 2^n in pixel size, we can get an image without any
%imaginary part after we perform ifft. It will be much better and the
%efficiency of Fourier Transformation is higher.
%Also add and evaluation for the convergence of the iteration

%rectangular picture changed to a square picture
%read an image
IM=imread('image.jpg');
IM=rgb2gray(IM);
IM=imresize(IM,0.4);
IM=im2double(IM);
IM=imcrop(IM,[1 1 255 255]);
figure,imshow(IM);

%Generate black space outside of the picture
temp=zeros(1024,1024);
for x=385:640
    for y=385:640
        temp(x,y)=IM(x-384,y-384);
    end
end

IM=zeros(1024,1024);
for x=1:1024
    for y=1:1024
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


%Generate randon angles, well actually not so random
%fai=2*pi*rand(771,771,'double');
%IM_rand=rand(1024,1024,'double');
%FFT_IM_rand=fft2(IM_rand);
%FFT_IM_rand=fftshift(FFT_IM_rand);
%FFT_IM_rand_angle=angle(FFT_IM_rand);

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
angle_exact=angle(FFT_IM);
FFT_IM=abs(FFT_IM);

%get the frequency domain of the blur image and get the phase angle
FFT_IM_blur=fft2(IM_blur);
FFT_IM_blur=fftshift(FFT_IM_blur);
FFT_IM_blur_angle=angle(FFT_IM_blur);

%Generate a new image with the Fourier frequency of the blured image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*FFT_IM_blur_angle);
FFT_IM_new=fftshift(FFT_IM_new);
IM_new=ifft2(FFT_IM_new);
IM_new=abs(IM_new);

%Iteration between the real space and reciprocal space
Iteration=2000;
for k=1:1:Iteration
    for x=1:1:1024
        for y=1:1:1024
            if(x<=384 || x>640 || y<=384 || y>640)
                IM_new(x,y)=0;
            end
        end
    end
    FFT_IM_new=fft2(IM_new);
    FFT_IM_new=fftshift(FFT_IM_new);
    FFT_IM_new_theta=angle(FFT_IM_new);
    angle_diff=abs(FFT_IM_new_theta-angle_exact);
    error(k)=sum(angle_diff(:));
    FFT_IM_newer=FFT_IM.*exp(1i*FFT_IM_new_theta);
    FFT_IM_newer=fftshift(FFT_IM_newer);
    IM_newer=ifft2(FFT_IM_newer);
    IM_new=abs(IM_newer);
end

for x=1:1:1024
    for y=1:1:1024
        if(x<=384 || x>640 || y<=384 || y>640)
            IM_new(x,y)=0;
        end
    end
end

figure,imshow(IM_new,[]);
