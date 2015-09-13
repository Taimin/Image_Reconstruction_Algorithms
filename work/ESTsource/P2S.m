function y=P2S(x,alpha)
m=size(x,1);
n=size(x,2);
BigX=zeros(m,2*n);
BigX(:,n/2+1:3*n/2)=x;
for k=1:m
BigX(k,:)=My_FRFT_Centered(BigX(k,:),alpha);
end
BigX=fftshift(fft(BigX,[],1),1);
y=BigX/(n*sqrt(2));
return;
end

function Y=My_FRFT_Centered(X,alpha)
X=X(:);
N=length(X);
X=X.*exp(i*pi*(0:1:N-1)*alpha).';

n=[0:1:N-1, -N:1:-1].';
Factor=exp(-i*pi*alpha*n.^2/N);

x_tilde=[X; zeros(N,1)];
x_tilde=x_tilde.*Factor;    

XX=fft(x_tilde);
YY=fft(conj(Factor));
Y=ifft(XX.*YY);
Y=Y.*Factor;
Y=Y(1:N);
Y=Y.*exp(i*pi*(-N/2:1:(N/2-1))*alpha).';
end