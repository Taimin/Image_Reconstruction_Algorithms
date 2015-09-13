function dy=Lorenz(t,y)   % y(1)=x,y(2)=y,y(3)=z
dy=zeros(3,1);
dy(1)=10*(-y(1)+y(2));
dy(2)=28*y(1)-y(2)-y(1)*y(3);
dy(3)=y(1)*y(2)-8*y(3)/3;
