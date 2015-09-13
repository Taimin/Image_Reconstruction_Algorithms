function ftSlices = Projections2Slices(PJ,Theta,n,nz)

rsize = size(PJ,2); 
if mod(rsize,2)==0
PJ = PJ(:,2:rsize,:);
end
rsize = size(PJ,2);
ra = (rsize+1)/2;
num_proj = size(PJ,3);

num = 0;
ang_err = 0.01;
n2 = n*2;
ang = zeros(n2,1);
phi = zeros(n2,1);
ii = zeros(n2,1);
% BH
for hh = (n+n/2+1):1:n*2
kk = hh - n;
nv = (n/2+1)-kk;
angular_var = -1*atan(2*nv/n)*180/pi; 
num = num + 1;
ang(num,1) = (90-angular_var);
phi(num,1) = -1*atan(2*nv/n);
ii(num,1) = hh;
end
% BV
for hh = 1:1:n
kk = hh;
nv = (n/2+1)-kk;
angular_var = atan(2*nv/n)*180/pi;
num = num + 1;
ang(num,1) = angular_var;
phi(num,1) = atan(2*nv/n);
ii(num,1) = hh;
end
% BH
for hh = (n+1):1:(n+n/2)
kk = hh - n;
nv = (n/2+1)-kk;
angular_var = -1*atan(2*nv/n)*180/pi; 
num = num + 1;
ang(num,1) = -(90+angular_var);
phi(num,1) = -1*atan(2*nv/n);
ii(num,1) = hh;
end

ftSlices = zeros(n2,n2,nz);
ftSlices(:) = -1;

for hh = 1:num_proj

tempR = squeeze( PJ(:,:,hh) );
angular_var = Theta(hh,1);

for kk = 1:num
if abs(ang(kk,1)-angular_var)<ang_err
alpha = 1 / cos(phi(kk,1));

if ii(kk,1)>=1&&ii(kk,1) <= n
if (n/2+1)<=ra
newTemp = tempR( :,ra-(n/2):ra+(n/2-1) );
else
newTemp = zeros(nz,n);
newTemp( :,(n/2+1)-(rsize-1)/2:(n/2+1)+(rsize-1)/2 ) = tempR;   
end   
Slice = P2S(newTemp,alpha);
end

if ii(kk,1)>=(n+1)&&ii(kk,1)<=(n+n/2)
if (n/2+1)<=ra
newTemp = tempR( :,ra-(n/2):ra+(n/2-1) );
else
newTemp = zeros(nz,n);
newTemp( :,(n/2+1)-(rsize-1)/2:(n/2+1)+(rsize-1)/2 ) = tempR;
end
Slice = P2S(newTemp,alpha);
end

if ii(kk,1)>=(n+n/2+1)&&ii(kk,1)<=n*2
tempR = fliplr(tempR);    
if (n/2+1)<=ra
newTemp = tempR( :,ra-(n/2):ra+(n/2-1) );
else
newTemp = zeros(nz,n);
newTemp( :,(n/2+1)-(rsize-1)/2:(n/2+1)+(rsize-1)/2 ) = tempR;   
end
Slice = P2S(newTemp,alpha);
end

Hrang = fix( (n-1)*cos(phi(kk,1)) );
Slice1 = Slice;
Slice1(:) = -1;
Slice1(:,n+1-(Hrang):n+1+Hrang) = Slice(:,n+1-(Hrang):n+1+Hrang);
ftSlices(ii(kk,1),:,:) = (Slice1).';
break;
end
end

end
