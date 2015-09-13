%Two one-dimensional Gaussian convolution

img=imread('image.jpg');
img=rgb2gray(img);

sigma=10;
x=floor(3*sigma);
Gauss=zeros(2*x+1,1);

for u=1:2*x+1
    Gauss(u)=exp((-(u-x-1)^2)/(2*sigma^2));
end
sum_Gauss=sum(sum(Gauss));
Gauss=Gauss./sum_Gauss;

S=conv2(double(img),Gauss,'same');
S=conv2(double(S),Gauss','same');

imshow(S,[]);