img=im2double(imread('circle.tif'));
img=(img==1);
[m,n]=size(img);

rowq=linspace(1,m,100);
colq=linspace(1,n,100);
[rowq,colq]=meshgrid(rowq,colq);
img1=interp2(img,rowq,colq,'nearest');%a good way to scale down an image
imshow(img1);

theta=pi/4;
for z=1:1
    rowq=linspace(1+m/2*tan(theta),m+m/2*tan(theta),100);
    colq=linspace(1,n,100);
    [rowq,colq]=meshgrid(rowq,colq);
    img1=interp2(img,rowq,colq,'nearest',1);%a good way to scale down an image
    [a,b]=size(img1);
    rowq=linspace(1,a*cos(theta),100);
    colq=linspace(1,b,100);
    [rowq,colq]=meshgrid(rowq,colq);
    img1=interp2(img1,rowq,colq,'nearest',1);
    figure, imshow(img1);
end

theta=pi/4;
figure;i=1;
for z=linspace(1,512,12)
    
    subplot(3,4,i);
    rowq=linspace(1+(m/2-z)*tan(theta),m+(m/2-z)*tan(theta),100);
    colq=linspace(1,n,100);
    [rowq,colq]=meshgrid(rowq,colq);
    img1=interp2(img,rowq,colq,'nearest',1);%a good way to scale down an image
    [a,b]=size(img1);
    rowq=linspace(1,a*cos(theta),100);
    colq=linspace(1,b,100);
    [rowq,colq]=meshgrid(rowq,colq);
    img1=interp2(img1,rowq,colq,'nearest',1);
    imshow(img1);
    i=i+1;
end