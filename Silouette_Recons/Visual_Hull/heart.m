figure
[x,y,z]=meshgrid(linspace(-3,3));                            %做出网格meshgrid                                    
p=(x.^2+(9/4)*y.^2+z.^2-1).^3-x.^2.*z.^3-(9/80)*y.^2.*z.^3;  %实现结果的表达
isosurface(x,y,z,p,0,x);
axis equal;
axis off;
view(0,45);          %视角的控制
colormap([1 0 0]);   %绘图颜色红色
brighten(0.5);       %增亮
camlight right;      %光源位置
lighting phong;      %光照模式