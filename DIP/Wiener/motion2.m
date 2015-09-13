[m,n]=size(img);
%figure,imshow(img);
p=m;
q=n;

T=1;
a=0;
b=0.05;

motion_blur_fft=zeros(p,q);
for u=1:p
    for v=1:q
        c=(u-floor(p/2)-1)*a+(v-floor(q/2)-1)*b;
        if  c== 0
            motion_blur_fft(u,v)=T;
        else
            motion_blur_fft(u,v)=b*(1-exp(-1i*2*pi*(v-floor(q/2)-1)/b/q))/(1-exp(-1i*2*pi*(v-floor(q/2)-1)/q));
        end
            
    end
end

motion_blur=ifft(motion_blur_fft);


e=motion_blur(1,:);
f=conj(e);
%plot(e.*f);
figure,plot(sqrt(e.*f));
ef=find(sqrt(e.*f)>0.5);

syms x;
fx=b*(heaviside(x+b*m/2)-heaviside(x-b*m/2));
figure,ezplot(fx,[-2 60]);

Fw=fourier(fx);
figure,ezplot(abs(Fw),[-6 6]);