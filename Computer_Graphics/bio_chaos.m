% u=linspace(3,4,100);
% x=zeros(101,201);
% x(51,1)=0.5;
% 
% for m=1:100
%     for n=1:200
%         x(n+1,m)=u(m)*x(n,m)*(1-x(n,m));
%     end
% end
% 
% imshow(x,[]);

N=80000;
u=linspace(-2.6,6,N);
x=0.5;
X=zeros(301,N);
hold on;

for n=1:N
   for m=1:300
       x(m+1)=u(n)*x(m)*(1-x(m));
       %plot(u(n),x(m+1),'k.','markersize',2);%draw dot one by one
   end
    X(:,n)=x(:);
end

