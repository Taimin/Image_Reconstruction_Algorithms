[t,y]=ode45(@Lorenz,[0,30],[12,2,9]);
subplot(221);
plot(t,y(:,1));
subplot(222);
plot(t,y(:,2))
subplot(223);
plot(t,y(:,3))
subplot(224);
plot3(y(:,1),y(:,2),y(:,3))
view([20 42]);

[t,y]=ode45(@Lorenz,[0 30],[12 2 9]);
clf;
axis([-20 20 -25 25 10 50]);
view([20 42]);
hold on;
comet3(y(:,1),y(:,2),y(:,3));%显示吸引子的绘制过程

[t,]=ode45(@Lorenz,[0 30],[12 2 9]);
   m=moviein(100);
   axis([-20 20 -25 25 -10 50]);
   shading flat;
   h=plot3(y(:,1),y(:,2),y(:,3));
  for j=1:100
       rotate(h,[0 0 1],1.8);  %沿Z轴旋转
       axis([-20 20 -25 25 -10 50]);
       shading flat;
       m(:,j)=getframe;
       [X,map]=getframe;
      imwrite(X,['Lz' int2str(j) '.bmp'],'bmp');%写入bmp文件
  end
  movie(m,5)   %循环播放5次
  
  clf;
hold on;
[t,u]=ode45('Lorenz',[0 6],[12 2 9]);
plot(t,u(:,3),'color','r');
[t,v]=ode45('Lorenz',[0 6],[12 2.01 9]);
plot(t,v(:,3),'color','b');
[t,w]=ode45('Lorenz',[0 6],[12 1.99 9]);
plot(t,w(:,3),'color','k');