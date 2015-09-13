clear ;
%%%%%%%%%%%%%%%%%%%%
%A diffractive circle with more than 90% of energy in 700mm
%of diffractive distance. The uint is millimeter in the program.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lamd=0.532*10^-3;%% incident wavelength
w=0.75;%% waist of incident beam
R=4;%% limiting aperture of the element
D=700;%% diffractive distance;
r1=1.5;r2=3;%% inside and outside radius of circle
L0=10;%%mm
k=2*pi/lamd;%%%wave number;
N=256;
%%%%%%%%%%%%% judging(analytic transformation)
Judging=(sqrt(N*lamd*D)<=L0);
if Judging==0
    disp('????ERROR');
    disp('......Fresnel Analytic Transformation is not satisfied');
    break;
end
%%%%%%%%%%%%%
x11=linspace(-L0/2,L0/2,N);y11=linspace(-L0/2,L0/2,N);
[x1,y1]=meshgrid(x11,y11);
J1=zeros(N);
for m=1:N
    for n=1:N
        if x1(m,n)^2+y1(m,n)^2<=R^2
            J1(m,n)=1;
        end
    end
end
A=exp(-(x1.^2+y1.^2)/w^2).*J1;
%%%%%
fx=1/L0*(-N/2:N/2-1);fy=1/L0*(-N/2:N/2-1);
[fx,fy]=meshgrid(fx,fy);
%%%%%
JJ=zeros(N);
for m=1:N
    for n=1:N
        if x1(m,n)^2+y1(m,n)^2>=r1^2&&x1(m,n)^2+y1(m,n)^2<=r2^2
            JJ(m,n)=1;
        end
    end
end
a=sum(sum(A.^2))/sum(sum(JJ.^2));
J2=JJ*sqrt(a);
%imagesc(J2);axis square;colormap(gray)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% G-S
%pha0=load('C:\Documents and Settings\wjq\My Documents\MATLAB\pha90.txt');
pha0=2*pi*rand(N)-pi;M=0;CC=[];eta=0;%random phase -pi to pi
while eta<0.990
    M=M+1;
    U1=A.*exp(i*pha0);
    temp1=(fft2(U1));
    temp2=exp(i*k*D*(1-lamd^2/2*(fx.^2+fy.^2)));
    U2=ifft2(temp1.*temp2);
    pha2=angle(U2);
    A2=abs(U2);
    I2=abs(U2).^2;
    Err(M)=sum(sum((I2-J2.^2 ).^2));
    eta(M)=sum(sum(I2.*JJ))/sum(sum(I2));
    subplot(221);plotyy(1:M,Err,1:M,eta)
    title('Err (left) and eta (right)');xlabel('M');
    subplot(222);imagesc(x11,y11,J2);axis square;title('Object function')
    xlabel('x / mm');ylabel('y / mm');zlabel('Amplitude')
    subplot(223);imagesc(x11,y11,A2);axis square;title('Output function')
    xlabel('x / mm');ylabel('y / mm');zlabel('Amplitude')
    %%%%%%%%
    U2=J2.*exp(i*pha2);
    tmep3=fft2(U2);
    temp4=exp(-i*k*D*(1-lamd^2/2*(fx.^2+fy.^2)));
    U11=ifft2(tmep3.*temp4);
    pha0=angle(U11);
    subplot(224);imagesc(x11,y11,pha0);axis square; title('phase of DOE')
    xlabel('x / mm');ylabel('y / mm')
    pause(0.01)
end 