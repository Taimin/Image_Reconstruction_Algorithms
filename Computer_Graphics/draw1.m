x=2*rand(5000,1)-1;
y=2*rand(5000,1)-1;
z=2*rand(5000,1)-1;
v=x.^2+y.^2+z.^2;

[xq,yq,zq]=meshgrid(-0.8:0.03:0.8,-0.9:0.03:0.9,-0.8:0.03:0.8);

vq=griddata(x,y,z,v,xq,yq,zq);

%surf(xq,yq,vq);%wrong xq and yq must be two dimensional array, not three
%dimensional array

p=patch(isosurface(xq,yq,zq,vq,0.36));

isonormals(xq,yq,zq,vq,p);

p.FaceColor='red';
p.EdgeColor='none';
daspect([1,1,1])
view(3); axis tight
camlight;
lighting gouraud;