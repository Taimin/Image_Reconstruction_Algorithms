function Logistic ()

clear;
clf;
u=2.6:0.001:4.0;%logistic parameter
x=0.1;
for i=1:300
x=u.*(x-x.^2);
end
for j=1:80
x=u.*(x-x.^2);
plot(u,x,'k.','markersize',2)
hold on;
end
grid on