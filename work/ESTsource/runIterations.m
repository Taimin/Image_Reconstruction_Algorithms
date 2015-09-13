function struct_out = runIterations(struct_out)
ind_ftSlices = find(struct_out.ftSlices~=-1);
indx_f = setdiff((1:numel(struct_out.ftSlices)).',ind_ftSlices); 
aa = sum(abs( struct_out.ftSlices(ind_ftSlices) ));

switch struct_out.algorithm

case 1   
for hh = 1:struct_out.UpdateRate
ind_n = find(struct_out.InitialObj<0);
ind = union(ind_n,struct_out.ind_Boundary);
struct_out.InitialObj(ind) = 0;
ft = PseudopolarFFT3(struct_out.InitialObj);    
err = sum(abs( ft(ind_ftSlices)-struct_out.ftSlices(ind_ftSlices) ))/aa;
IterationNum = (struct_out.UpdateNum - 1)*struct_out.UpdateRate+hh;
struct_out.ErrorArray(IterationNum,1) = err;

if err<struct_out.BestError
struct_out.BestError = err;
struct_out.BestObj = struct_out.InitialObj;
end

ft(ind_ftSlices) = struct_out.ftSlices(ind_ftSlices);
struct_out.InitialObj = real( Inv_PseudopolarFFT3(ft) );
end

case 2   
ErrTol = 1.e-6;
%MaxIts = 4;

N3=size(struct_out.ftSlices,3);
N=size(struct_out.ftSlices,1);
N=N/2;
W1=sqrt(abs(-N:1:N-1)/N);
W1(N+1)=sqrt(1/(4*N));
W1=ones(2*N,1)*W1;
W2=W1.^2;
W=repmat(W2,[1 1 N3]);

% Initialization
perr = inf;
xt = APPFFT3new(W.*struct_out.ftSlices,struct_out.ind_Boundary,indx_f);
for hh=1:struct_out.UpdateRate

if perr>ErrTol,
temp = PPFFT3new(struct_out.InitialObj,struct_out.ind_Boundary,indx_f);    
rk = xt - APPFFT3new( W.*temp,struct_out.ind_Boundary,indx_f );

perr=sum(abs( temp(ind_ftSlices)-struct_out.ftSlices(ind_ftSlices) ))/aa;%perr=max(max(abs(pk)));
%fprintf(['Iteration ',int2str(hh-1),': Residual error=']);
%fprintf('%f\n',perr);
IterationNum = (struct_out.UpdateNum - 1)*struct_out.UpdateRate+hh;
struct_out.ErrorArray(IterationNum,1) = perr;

temp=APPFFT3new( W.*PPFFT3new(rk,struct_out.ind_Boundary,indx_f),struct_out.ind_Boundary,indx_f );%temp = PtPa(pk,Age,Pre);
a0 = sum(abs(rk(:)).^2);
a1 = sum(conj(rk(:)).*temp(:));
a=a0/a1;
struct_out.BestObj=struct_out.InitialObj+a*rk;
struct_out.BestObj = real(struct_out.BestObj);
indx_neg = find(struct_out.BestObj<0);
struct_out.BestObj( indx_neg ) = 0;
struct_out.InitialObj = struct_out.BestObj;
else
    
end

end

case 3   
for hh = 1:struct_out.UpdateRate
struct_out.InitialObj(struct_out.ind_Boundary) = 0;
ft = PseudopolarFFT3(struct_out.InitialObj);    
err = sum(abs( ft(ind_ftSlices)-struct_out.ftSlices(ind_ftSlices) ))/aa;
IterationNum = (struct_out.UpdateNum - 1)*struct_out.UpdateRate+hh;
struct_out.ErrorArray(IterationNum,1) = err;

if err<struct_out.BestError
struct_out.BestError = err;
struct_out.BestObj = struct_out.InitialObj;
end

ft(ind_ftSlices) = struct_out.ftSlices(ind_ftSlices);
struct_out.InitialObj = real( Inv_PseudopolarFFT3(ft) );
end

case 4  
ErrTol = 1.e-6;
%MaxIts = 4;

N3=size(struct_out.ftSlices,3);
N=size(struct_out.ftSlices,1);
N=N/2;
W1=sqrt(abs(-N:1:N-1)/N);
W1(N+1)=sqrt(1/(4*N));
W1=ones(2*N,1)*W1;
W2=W1.^2;
W=repmat(W2,[1 1 N3]);

% Initialization
perr = inf;
xt = APPFFT3new(W.*struct_out.ftSlices,struct_out.ind_Boundary,indx_f);
for hh=1:struct_out.UpdateRate

if perr>ErrTol,
temp = PPFFT3new(struct_out.InitialObj,struct_out.ind_Boundary,indx_f);    
rk = xt - APPFFT3new( W.*temp,struct_out.ind_Boundary,indx_f );

perr=sum(abs( temp(ind_ftSlices)-struct_out.ftSlices(ind_ftSlices) ))/aa;%perr=max(max(abs(pk)));
%fprintf(['Iteration ',int2str(hh-1),': Residual error=']);
%fprintf('%f\n',perr);
IterationNum = (struct_out.UpdateNum - 1)*struct_out.UpdateRate+hh;
struct_out.ErrorArray(IterationNum,1) = perr;

temp=APPFFT3new( W.*PPFFT3new(rk,struct_out.ind_Boundary,indx_f),struct_out.ind_Boundary,indx_f );%temp = PtPa(pk,Age,Pre);
a0 = sum(abs(rk(:)).^2);
a1 = sum(conj(rk(:)).*temp(:));
a=a0/a1;
struct_out.BestObj=struct_out.InitialObj+a*rk;
struct_out.BestObj = real(struct_out.BestObj);
struct_out.InitialObj = struct_out.BestObj;
else
    
end

end

end
