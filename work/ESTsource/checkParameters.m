function dd = checkParameters(initial_pars)

n = initial_pars.n;
nz = initial_pars.nz;
UpdateRate = initial_pars.UpdateRate;
TotalIterations = initial_pars.TotalIterations;

if mod(TotalIterations,UpdateRate) ~= 0
dd = 1;
return;
end

PJ = My_importdata(initial_pars.filename_PJ,initial_pars.filename_PJ_Dimension);
Theta = importdata(initial_pars.filename_Theta);
Theta = Theta(:);
num_PJ = size(PJ,3);
num_Theta = size(Theta,1);
if num_PJ ~= num_Theta
dd = 2;
return;
end

nx_PJ = size(PJ,1);
if nx_PJ ~= nz
dd = 3;
return;
end

if isfield(initial_pars,'Boundary')
Boundary = importdata(initial_pars.filename_Boundary);
xb = size(Boundary,1);
yb = size(Boundary,2);
zb = size(Boundary,3);
if xb~=n || yb~=n || zb~=nz 
dd = 4;
return;
end
end

if isfield(initial_pars,'filename_InitialObj')
InitialObj = importdata(initial_pars.filename_InitialObj);
xi = size(InitialObj,1);
yi = size(InitialObj,2);
zi = size(InitialObj,3);
if xi~=n || yi~=n || zi~=nz 
dd = 5;
return;
end
end

num_fit = 0;
num = 0;
ang_err = 0.01;
n2 = n*2;
ang = zeros(n2,1);
% BH
for hh = (n+n/2+1):1:n*2
kk = hh - n;
nv = (n/2+1)-kk;
angular_var = -1*atan(2*nv/n)*180/pi; 
num = num + 1;
ang(num,1) = (90-angular_var);
end
% BV
for hh = 1:1:n
kk = hh;
nv = (n/2+1)-kk;
angular_var = atan(2*nv/n)*180/pi;
num = num + 1;
ang(num,1) = angular_var;
end
% BH
for hh = (n+1):1:(n+n/2)
kk = hh - n;
nv = (n/2+1)-kk;
angular_var = -1*atan(2*nv/n)*180/pi; 
num = num + 1;
ang(num,1) = -(90+angular_var);
end
for hh = 1:num_Theta
angular_var = Theta(hh,1);
for kk = 1:num
if abs(ang(kk,1)-angular_var)<ang_err
num_fit = num_fit + 1;    
break;
end
end
end
if num_fit ~= num_Theta
dd = 6;
return;
end

dd = 0;
