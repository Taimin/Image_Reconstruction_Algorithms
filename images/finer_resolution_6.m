%random phase generated should be central symmetrical, otherwise, the
%picture obtained from inverse Fourier transformation will have imaginary
%part and that's not good!

IM=zeros(600,600);

%Generate an image and show it
for k=0:2:19
    for j=0:2:19
        IM(100+20*k:120+20*k,100+20*j:120+20*j)=1;
    end
end
figure,imshow(IM);

%get the frequency domain of the sharp image, simulate the experimental
%diffraction pattern
FFT_IM=fft2(IM);
FFT_IM=fftshift(FFT_IM);
FFT_IM=abs(FFT_IM);
FFT_IM_log=log(FFT_IM);

%Generate randon angles, well actually not so random
%fai=2*pi*rand(600,600,'double');
IM_rand=rand(600,600,'double');
FFT_IM_rand=fft2(IM_rand);
FFT_IM_rand=fftshift(FFT_IM_rand);
FFT_IM_rand_theta=angle(FFT_IM_rand);

%Generate a new image with the Fourier frequency of the blured image and the random angles
FFT_IM_new=FFT_IM.*exp(1i*FFT_IM_rand_theta);
FFT_IM_new=fftshift(FFT_IM_new);
IM_new=abs(ifft2(FFT_IM_new));

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
    FFT_IM_newer=fftshift(FFT_IM_newer);
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
