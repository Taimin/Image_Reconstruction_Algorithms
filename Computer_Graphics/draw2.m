%�������ݵ�ɢ��ͼ����ֵ���һ�����ֵ��
rng shuffle;
x=2*rand(5000,1)-1;
y=2*rand(5000,1)-1;
z=2*rand(5000,1)-1;

% [X,Y,Z]=meshgrid(x,y,z);
% V=X.^2+Y.^2+Z.^2;

v=x.^2+y.^2+z.^2;

scatter3(x,y,z,15,v);%ɢ��ͼ
colorbar('hot');
hold on;

[xq,yq,zq]=meshgrid(-1:0.02:1,-1:0.02:1,-1:0.02:1);
vq = griddata(x,y,z,v,xq,yq,zq,'natural');%��ֵ����x,y,z����vֵ���xq,yq,zq����vqֵ

isosurface(xq,yq,zq,vq,0.36);%��ͼ����ֵ��

figure;
