function Y=Adj_PseudopolarFFT3(X)
N=size(X,1);
N3=size(X,3);
if N3 == 1
F1 = 3;
F2 = 4;
else
F1 = 1;
F2 = 2;
end
N=N/2;
Y=zeros(N,N,N3);

f_tilde=zeros(2*N,N,N3);
f_tilde=permute(X(1:N,:,:),[2 1 3]);
for ll=-N:1:N-1,
f_tilde(ll+N+1,:,:)=reshape(My_FRFT_Centered(f_tilde(ll+N+1,:,:),ll/N,N,N3),1,N,N3);
end
f_tilde=My_IFFT_Centered(f_tilde,2*N,F1);
Y=f_tilde(N/2+1:3*N/2,:,:);

f_tilde=zeros(N,2*N,N3);
f_tilde=X(N+1:2*N,:,:);
for ll=-N:1:N-1,
f_tilde(:,ll+N+1,:)=reshape(My_FRFT_Centered(f_tilde(:,ll+N+1,:),ll/N,N,N3),N,1,N3);
end
f_tilde=My_FFT_Centered(f_tilde,2*N,F2);
Y = Y + f_tilde(:,N/2+1:3*N/2,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Subfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Y=My_FFT_Centered(X,N,F)
NC = N/2+1;
switch F
case 1
X = circshift(X,[-(NC-1) 0 0]);
X = fft(X,[],1);
Y = fftshift(X,1);
case 2
X = circshift(X,[0 -(NC-1) 0]);
X = fft(X,[],2);
Y = fftshift(X,2);
case 3
X = circshift(X,[-(NC-1) 0]);
X = fft(X,[],1);
Y = fftshift(X,1);    
case 4
X = circshift(X,[0 -(NC-1)]);
X = fft(X,[],2);
Y = fftshift(X,2);    
end

function Y=My_IFFT_Centered(X,N,F)
NC = N/2+1;
switch F
case 1
X = circshift(X,[-(NC-1) 0 0]);
X = ifft(X,[],1)*N;
Y = fftshift(X,1);
case 2
X = circshift(X,[0 -(NC-1) 0]);
X = ifft(X,[],2)*N;
Y = fftshift(X,2);
case 3
X = circshift(X,[-(NC-1) 0]);
X = ifft(X,[],1)*N;
Y = fftshift(X,1);    
case 4
X = circshift(X,[0 -(NC-1)]);
X = ifft(X,[],2)*N;
Y = fftshift(X,2);    
end

function Y=My_FRFT_Centered(X,alpha,N,N3)
X = reshape(X,N,N3);
preFactor = (exp(i*pi*(0:1:N-1)*alpha).')*ones(1,N3);
X=X.*preFactor;

n=([0:1:N-1, -N:1:-1].')*ones(1,N3);
Factor=exp(-i*pi*alpha*n.^2/N);

x_tilde=[X; zeros(N,N3)];
x_tilde=x_tilde.*Factor;    

XX=fft(x_tilde,[],1);
YY=fft(conj(Factor),[],1);
Y=ifft(XX.*YY,[],1);
Y=Y.*Factor;
Y=Y(1:N,:);

postFactor = (exp(i*pi*(-N/2:1:(N/2-1))*alpha).')*ones(1,N3);
Y=Y.*postFactor;