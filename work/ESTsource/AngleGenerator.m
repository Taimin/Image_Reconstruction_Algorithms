function ang = AngleGenerator(n)

num = 0;
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
