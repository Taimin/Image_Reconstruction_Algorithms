%wrong result because you use continuous integration to calculate discrete
%function
[m,n]=size(img);
%figure,imshow(img);
p=2*m;
q=2*n;

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
            motion_blur_fft(u,v)=T/(pi*c)*sin(pi*c)*exp(-1i*pi*c);
        end
            
    end
end

motion_blur=ifft(ifftshift(motion_blur_fft));