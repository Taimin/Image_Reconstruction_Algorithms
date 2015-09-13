
img=imread('digital-images-week3_quizzes-original_quiz.jpg');
img=im2double(img);
[m,n]=size(img);

filter1=repmat(1/9,3,3);
img_filted1=imfilter(img,filter1,'replicate');

down_sized_img=zeros(floor(m/2)+1,floor(n/2)+1);
for x=1:floor(m/2)+1
    for y=1:floor(n/2)+1
        down_sized_img(x,y)=img_filted1(2*x-1,2*y-1);
    end
end

figure;
imshow(img);
figure;
imshow(down_sized_img,[]);

up_sized_img=zeros(m,n);
for x=1:floor(m/2)+1
    for y=1:floor(n/2)+1
        up_sized_img(2*x-1,2*y-1)=down_sized_img(x,y);
    end
end

filter2=[0.25 0.5 0.25;0.5 1 0.5;0.25 0.5 0.25];%bilinear interpolation

up_sized_img=imfilter(up_sized_img,filter2);

figure;
imshow(up_sized_img,[]);

MSE=1/m/n*sum(sum((up_sized_img-img).^2));
PSNR=10*log10(255^2/MSE);
