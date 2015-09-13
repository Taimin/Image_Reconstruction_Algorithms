N1=8;N2=16;
n=0:N1-1;k1=0:N1-1;k2=0:N2-1;
w=2*pi*(0:2047)/2048;
Xw=(1-exp(-1j*4*w))./(1-exp(-1j*w));
xn=[(n>=0)&(n<4)];
X1k=fft(xn,N1);
X2k=fft(xn,N2);
subplot(3,2,1);plot(w/pi,abs(Xw));xlabel('w/¦Ð')
subplot(3,2,2);plot(w/pi,angle(Xw));axis([0,2,-pi,pi]);line([0,2],[0,0]);
xlabel('w/¦Ð')
subplot(3,2,3);stem(k1,abs(X1k),'.');
xlabel('k(w=2¦Ðk/N1)');ylabel('|X1(k)|');hold on
plot(N1/2*w/pi,abs(Xw))
subplot(3,2,4);stem(k1,angle(X1k));
axis([0,N1,-pi,pi]);line([0,N1],[0,0]);
xlabel('k(w=2¦Ðk/N1)');ylabel('Arg|X1(k)');hold on
plot(N1/2*w/pi,angle(Xw))
subplot(3,2,5);stem(k2,abs(X2k));
axis([0,N1,-pi,pi]);line([0,N1],[0,0]);
xlabel('k(w=2¦Ðk/N2)');ylabel('|X2(k)|');hold on
plot(N2/2*w/pi,abs(Xw))
subplot(3,2,6);stem(k2,angle(X2k),'.');
xlabel('k(w=2¦Ðk/N2)');ylabel('|X2(k)|');hold on
plot(N2/2*w/pi,angle(Xw))