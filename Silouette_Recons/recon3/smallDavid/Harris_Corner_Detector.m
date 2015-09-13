%implementation of Harris Corner Detector

img=imread('david_00.jpg');
img=rgb2gray(img);
threshold=10000;

[m,n]=size(img);
dx=[1,0,-1;2,0,-2;1,0,-1];
dy=dx';
imgdx=conv2(double(img),double(dx),'same');
imgdy=conv2(double(img),double(dy),'same');
IxIx=imgdx.*imgdx;
IyIy=imgdy.*imgdy;
IxIy=imgdx.*imgdy;

Gauss_F=fspecial('gaussian',13,2);
IxIx=conv2(IxIx,Gauss_F,'same');
IyIy=conv2(IyIy,Gauss_F,'same');
IxIy=conv2(IxIy,Gauss_F,'same');

points=zeros(m,n);

for x=1:m
    for y=1:n
        M=[IxIx(x,y),IxIy(x,y);IxIy(x,y),IyIy(x,y)];
        Eigen_M=eig(M);
        R=Eigen_M(1)*Eigen_M(2)/(Eigen_M(1)+Eigen_M(2));%Szeliski
        if(R>0)
            if(R > threshold)
                points(x,y)=1;
            end
        end
    end
end

figure,imshow(img);
figure,imshow(points);