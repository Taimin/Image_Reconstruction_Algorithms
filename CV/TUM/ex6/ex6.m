
img1=imread('batinria0.tif');
img2=imread('batinria1.tif');
K1 = [844.310547 0 243.413315; 0 1202.508301 281.529236; 0 0 1];
K2 = [852.721008 0 252.021805; 0 1215.657349 288.587189; 0 0 1];
inv_K1=inv(K1);%transform image coordinate into normalized coordinates
inv_K2=inv(K2);

x1 = [
   10.0000
   92.0000
    8.0000
   92.0000
  289.0000
  354.0000
  289.0000
  353.0000
   69.0000
  294.0000
   44.0000
  336.0000
  ];

y1 = [ 
  232.0000
  230.0000
  334.0000
  333.0000
  230.0000
  278.0000
  340.0000
  332.0000
   90.0000
  149.0000
  475.0000
  433.0000
    ];
 
x2 = [
  123.0000
  203.0000
  123.0000
  202.0000
  397.0000
  472.0000
  398.0000
  472.0000
  182.0000
  401.0000
  148.0000
  447.0000
    ];

y2 = [ 
  239.0000
  237.0000
  338.0000
  338.0000
  236.0000
  286.0000
  348.0000
  341.0000
   99.0000
  153.0000
  471.0000
  445.0000
    ];

Rz1=[0 1 0;-1 0 0;0 0 1];
Rz2=[0 -1 0;1 0 0;0 0 1];

num_of_points=length(x1);
a=zeros(num_of_points,9);

for n=1:num_of_points
    l=inv_K1*[x1(n),y1(n),1]';
    r=inv_K2*[x2(n),y2(n),1]';
    x1(n)=l(1);
    y1(n)=l(2);
    x2(n)=r(1);
    y2(n)=r(2);
end

for n=1:num_of_points
    a(n,:)=kron([x1(n),y1(n),1],[x2(n),y2(n),1]);
end

rank_a=rank(a);

%Find minimizer for |a*E|
[Ua,Da,Va]=svd(a);
%Unstack E
E=reshape(Va(:,9),3,3);

[U,D,V]=svd(E);
if det(U)<0||det(V)<0
    [U,D,V]=svd(-E);
end
%project E onto essential space by replace eigenvalues
D(1,1)=1;
D(2,2)=1;
D(3,3)=0;

%Final essential matrixl
E=U*D*V';

R1=U*Rz1'*V';
R2=U*Rz2'*V';
T1_hat=U*Rz1*D*U';
T2_hat=U*Rz2*D*U';

T1 = [ -T1_hat(2,3); T1_hat(1,3); -T1_hat(1,2) ];
T2 = [ -T2_hat(2,3); T2_hat(1,3); -T2_hat(1,2) ];

%compute scene reconstruction and correct combination of R and T
M=zeros(3*num_of_points,num_of_points+1);
for n=1:num_of_points
    x2_hat=[0,-1,y2(n);1,0,-x2(n);-y2(n),x2(n),0];
    M(3*n-2 : 3*n, n) = x2_hat * R1 * [x1(n),y1(n),1]';
    M(3*n-2 : 3*n, num_of_points+1) = x2_hat * T2;
end

%get depth values
[V,D]=eig(M'*M);
lambda=V(1:num_of_points,1);
gamma=V(num_of_points+1,1);
