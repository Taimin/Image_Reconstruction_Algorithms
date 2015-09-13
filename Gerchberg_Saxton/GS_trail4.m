%%%%%%%%%%%%%%%高斯光束%%%%%%%%%%%%%
w=0.6328e-3;
p=260;
z=1e3;
boe=150;
m=4;
n=boe/(w*z);
[x,y]=meshgrid(-m/2:1/n:m/2,-m/2:1/n:m/2);
I=exp(-1.5*(x.^2+y.^2));  %二维高斯光束
%plot(x,I);
%矩形分布%
[a,b]=meshgrid(-m/2:1/n:m/2,-m/2:1/n:m/2);
g=exp(-((a.^2/9).^100+(b.^2/9).^100));      %二维矩形分布

%%%%%%%%%%%GS算法主体部分%%%%%%%%%%%%%%

FB=ifft2(g);
FB0=FB;
FBi=angle(FB0);
FBi0=exp(1i*FBi);
FBB=FBi0;
for k=1:p
    AA=I.*FBB;
    FA=fft2(AA);
    FAm=abs(FA);   %光束的幅值
    FAi1=angle(FA);
    FAi=exp(1i*FAi1);
    BB=g.*FAi;
    FB=ifft2(BB);
    FBi1=angle(FB);
    FBi=exp(1i*FBi1);
    FBB=FBi;
end

FAm=FAm.^2/max(FAm.^2);     %归一化幅值

figure, imagesc(x,y,I),colormap(hot);