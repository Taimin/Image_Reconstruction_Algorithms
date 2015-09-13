%create a circle which can be used in 3D reconstruction
m=512;
n=512;
r=floor(min(m,n)/2);
img=zeros(m,n);

for x=1:m
   for y=1:n
      if (x-floor(m/2)-1)^2+(y-floor(n/2)-1)^2 < (r-1)^2
          img(x,y)=1;
      end
   end
end

figure,imshow(img);

img=zeros(m,n);
for x=1:512
    for y=1:512
        if (x-256)^2+(y-256)^2 < 200^2
            img(x,y)=1;
        end
    end
end

figure, imshow(img);
imwrite(img,'circle.tif');