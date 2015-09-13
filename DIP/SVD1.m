%SVD for data compression

img=ones(25,15);
for u=6:20
    for v=3:13
        if(v>=6 && v<=10 && u>=9 && u<= 17)
            img(u,v)=1;
        else
            img(u,v)=0;
        end
    end
end

[U V D]=svd(img);

img1=U(:,1:3)*V(1:3,1:3)*D(:,1:3)';