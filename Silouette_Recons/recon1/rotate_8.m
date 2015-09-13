close all;
clear;

a=[1 2 3];
b=repmat(a',1,3);
c=repmat(a,3,1);
d=reshape(b,[],1);
e=reshape(c,[],1);
f=[d e];
theta=pi/4;
R=[cos(theta),-sin(theta);sin(theta),cos(theta)];
f_r=R*f';

%visualize
scatter(f_r(1,:),f_r(2,:));
hold on;
scatter(f(:,1)',f(:,2)');
axis equal;