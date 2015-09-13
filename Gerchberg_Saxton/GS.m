clear;clc;
u=1e-6; 
N=512;
dx=17*u; 
dy=17*u;
x=dx.*ones(N,1)*[-N/2:N/2-1];
y=dy.*ones(N,1)*[-N/2:N/2-1];
y=y';
D=imread('C:\Documents and Settings\Administrator\×ÀÃæ\u=1585368023,3276163969&fm=0&gp=0.jpg');
D=imresize(D,[512,512]);
D1=D;
afft=fft2(abs(D));
ampg0=abs(double(D)/255);
b=abs(afft);
angd=angle(afft);
x=b;
q=sinc(x);
ang1=angd+2*pi*(rand(N,N)-0.5*ones(N,N))*q;
ang=ang1;
for k=0:5
    G1=exp(j*ang);
   g=ifft2(G1);
   ampg=abs(g);
   angg=angle(g);
   if (max(max(ampg.^2-(ampg0).^2))<0.001)
       break;
   else   
       ampg=ampg0;
       g=ampg0*exp(j*angg);
       G2=ifft2(g);
%       ampG2=abs(G2);
       angG2=angle(G2);
       ampG2=1;
%         abs(G2)=1;
       ang=angG2; 
    end
end
for n=1:N
    for m=1:N 
        h(m,n)=cos(ang(m,n));
        if h(m,n)>0
           h(m,n)=1; 
        else 
            h(m,n)=0;
        end 
    end
end
 figure;imshow(h);
 imwrite(h,'C:\Documents and Settings\Administrator\×ÀÃæ\GS.bmp')
%  F=abs(Dk);
 H=fft2(h);
%  figure;imshow(F/1000);
 figure;imshow(abs(H)/1000);