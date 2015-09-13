%implementation of the Gerchberg and Saxton algorithm
%real space: abs(fx), diffraction pattern: fft_fx_abs

interval=512;
x=linspace(-1,1,interval);

%chirp function 
fx=rectpuls(2*x).*exp(1i*30*pi*x.*x);
fx_theta=angle(exp(1i*30*pi*x.*x));
fx_abs=abs(fx);
%figure,plot(x,abs(fx));

%fft of the chirp function
fft_fx=fft(fx);
fft_fx=fftshift(fft_fx);
fft_fx_theta=angle(fft_fx);
fft_fx_abs=abs(fft_fx);
%figure,plot(x,fft_fx_abs);

%generate new function using random theta
rand_theta=2*pi*rand([1 512]);
fx_new=fx_abs.*exp(1i*rand_theta);
fft_fx_new=fft(fx_new);
fft_fx_new_theta=angle(fft_fx_new);

%generate newer function using fft of the chirp function
fft_fx_newer=fft_fx_abs.*exp(1i*fft_fx_new_theta);
fx_newer=ifft(fft_fx_newer);
fx_newer_theta=angle(fx_newer);

Iteration=2000;
for k=1:1:Iteration
    fx_new=fx_abs.*exp(1i*fx_newer_theta);
    fft_fx_new=fft(fx_new);
    fft_ft_new_theta=angle(fft_fx_new);
    fft_fx_newer=fft_fx_abs.*exp(1i*fft_fx_new_theta);
    fx_newer=ifft(fft_fx_newer);
    fx_newer_theta=angle(fx_newer);
end

figure,subplot(2,1,1),plot(x,fft_fx_theta);
subplot(2,1,2),plot(x,fft_fx_new_theta);
%subplot(2,2,2),plot(x,fx);
%subplot(2,2,4),plot(x,fx_abs.*exp(1i*fx_newer_theta));
