function Y = IPPFFT3new(X,Y0,indx_r,indx_f,MaxIts)
ErrTol = 1.e-6;
%MaxIts = 4;

N3=size(X,3);
N=size(X,1);
N=N/2;
W1=sqrt(abs(-N:1:N-1)/N);
W1(N+1)=sqrt(1/(4*N));
W1=ones(2*N,1)*W1;
W2=W1.^2;
W=repmat(W2,[1 1 N3]);

% Initialization
perr = 1e9;
xt = APPFFT3new(W.*X,indx_r,indx_f);
for j=1:MaxIts,

if perr>ErrTol,
rk = xt - APPFFT3new( W.*PPFFT3new(Y0,indx_r,indx_f),indx_r,indx_f );

perr=norm(rk(:));%perr=max(max(abs(pk)));
fprintf(['Iteration ',int2str(j-1),': Residual error=']);
fprintf('%f\n',perr);
			 
temp=APPFFT3new( W.*PPFFT3new(rk,indx_r,indx_f),indx_r,indx_f );%temp = PtPa(pk,Age,Pre);
a0 = sum(abs(rk(:)).^2);
a1 = sum(conj(rk(:)).*temp(:));
a=a0/a1;
Y1=Y0+a*rk;
Y1 = real(Y1);
indx_neg = find(Y1<0);
Y1( indx_neg ) = 0;
Y0 = Y1;
else
Y = Y0;
return;    
end

end
Y = Y0;