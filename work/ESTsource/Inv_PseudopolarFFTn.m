function xk = Inv_PseudopolarFFTn(X)
ErrTol = 1.e-6;
MaxIts = 3;

N3=size(X,3);
N=size(X,1);
N=N/2;
W1=sqrt(abs(-N:1:N-1)/N);
W1(N+1)=sqrt(1/(4*N));
W1=ones(2*N,1)*W1;
W2=W1.^2;
W=repmat(W2,[1 1 N3]);

% Initialization
xk = Adj_PseudopolarFFTn(W.*X);

if MaxIts>1,
temp=Adj_PseudopolarFFTn( W.*PseudopolarFFTn(xk) );%temp = PtPa(xk,Age,Pre);
pk=xk-temp;
rk=xk-temp;
	
% Conjugate gradient iteration
for j=2:MaxIts,
perr=norm(pk(:));%perr=max(max(abs(pk)));
%fprintf(['Iteration ',int2str(j-1),': Residual error=']);
%fprintf('%f\n',perr);
	
if perr>ErrTol,			
temp=Adj_PseudopolarFFTn( W.*PseudopolarFFTn(pk) );%temp = PtPa(pk,Age,Pre);
a0 = sum(abs(rk(:)).^2);
a1 = sum(conj(pk(:)).*temp(:));
	
a=a0/a1;
xk=xk+a*pk;		
rk=rk-a*temp;
			
bb = sum(abs(rk(:).^2));
b=bb/a0;
			
% Update
pk=rk+b*pk;
              
end

end
    
end
