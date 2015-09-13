%random phase generated should be central symmetrical, otherwise, the
%picture obtained from inverse Fourier transformation will have imaginary
%part and that's not good!

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

%Generate randon angles, well actually not so random
%fai=2*pi*rand(771,771,'double');
IM_rand=rand(771,771,'double');
FFT_IM_rand=fft2(IM_rand);
FFT_IM_rand=fftshift(FFT_IM_rand);
FFT_IM_rand_angle=angle(FFT_IM_rand);

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
FFT_IM=abs(FFT_IM);


%Generate a new image with the Fourier frequency of the blured image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*FFT_IM_rand_angle);
FFT_IM_new=fftshift(FFT_IM_new);
IM_new=ifft2(FFT_IM_new);
IM_new=abs(IM_new);

%Iteration between the real space and reciprocal space
Iteration=0;
for k=0:1:Iteration
    for x=1:1:771
        for y=1:1:771
            if(x<=300 || x>471 || y<=300 || y>471)
                IM_new(x,y)=0;
            end
        end
    end
    FFT_IM_new=fft2(IM_new);
    FFT_IM_new=fftshift(FFT_IM_new);
    FFT_IM_new_theta=angle(FFT_IM_new);
    FFT_IM_newer=FFT_IM.*exp(1i*FFT_IM_new_theta);
    FFT_IM_newer=fftshift(FFT_IM_newer);
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