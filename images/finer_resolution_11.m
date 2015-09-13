%improve the algorithm

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

%Generate randon angles, well actually not so random
%fai=2*pi*rand(771,771,'double');
%rand('seed',sum(100*clock));
IM_rand=rand(1024,1024,'double');
FFT_IM_rand=fft2(IM_rand);
FFT_IM_rand=fftshift(FFT_IM_rand);
FFT_IM_rand_angle=angle(FFT_IM_rand);

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
%angle_exact=angle(FFT_IM);
FFT_IM=abs(FFT_IM);

%Generate a new image with the Fourier frequency of the sharp image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*FFT_IM_rand_angle);
FFT_IM_new=fftshift(FFT_IM_new);
IM_new=ifft2(FFT_IM_new);

IM_newer=zeros(1024);

for x=1:1:1024
    for y=1:1:1024
        if(x>384 && x<=640 && y>384 && y<=640)
            IM_newer(x,y)=IM_new(x,y);
        end
        if(x<=384 || x>640 || y<=384 || y>640)
            IM_newer(x,y)=IM(x,y)-0.8*IM_new(x,y);
        end
    end
end


%Iteration between the real space and reciprocal space
Iteration=200;
for k=1:1:Iteration
    FFT_IM_newer=fft2(IM_newer);
    FFT_IM_newer=fftshift(FFT_IM_newer);
    FFT_IM_newer_theta=angle(FFT_IM_newer);
    %angle_diff=abs(FFT_IM_newer_theta-angle_exact);
    %error(k)=sum(angle_diff(:));
    FFT_IM_temp=FFT_IM.*exp(1i*FFT_IM_newer_theta);
    FFT_IM_temp=fftshift(FFT_IM_temp);
    IM_temp=ifft2(FFT_IM_temp);
    for x=1:1:1024
        for y=1:1:1024
            if(x>384 && x<=640 && y>384 && y<=640)
                IM_new(x,y)=IM_temp(x,y);
            end
            if(x<=384 || x>640 || y<=384 || y>640)
                IM_new(x,y)=IM_newer(x,y)-0.8*IM_temp(x,y);
            end
        end
    end

    IM_newer=IM_new;
end

%for x=1:1:1024
%    for y=1:1:1024
%        if(x<=384 || x>640 || y<=384 || y>640)
%            IM_new(x,y)=0;
%        end
%    end
%end

figure,imshow(IM_new,[]);