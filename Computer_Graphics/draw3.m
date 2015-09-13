a=xlsread('data.xlsx');

plot3(a(:,1),a(:,2),a(:,3),'ko');
hold on;
t1=linspace(min(a(:,1)),max(a(:,1)));
t2=linspace(min(a(:,2)),max(a(:,2)));
[X,Y]=meshgrid(t1,t2);

Z=griddata(a(:,1),a(:,2),a(:,3),X,Y,'v4');
%Z=interp2(c,d,a(:,3),X,Y,'cubic');%can not be used
grid on;
surf(X,Y,Z);
figure, mesh(X,Y,Z);
axis tight;
