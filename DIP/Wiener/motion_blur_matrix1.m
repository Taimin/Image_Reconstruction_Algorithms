%generate a motion blur matrix
close all;
clear;
theta=pi/4;%counter-clockwise is the positive direction
num_pixel=69;
line=1:num_pixel;
x=-(line-1)*sin(theta);%精确的直线xy坐标,以0 0为中心旋转
y=(line-1)*cos(theta);
m=round(max(x)-min(x)+1);
n=round(max(y)-min(y)+1);

i=1:m;%新建立一个坐标系
j=1:n;
%把精确直线的xy坐标变换到这个坐标系中
x=x-min(x)+1;
y=y-min(y)+1;

% [i,j]=meshgrid(i,j);
% i=reshape(i',1,[]);
% j=reshape(j',1,[]);

h=zeros(m+2,n+2);
% for a=1:m%wrong implementation
%     for b=1:n
%             near_x=[a-1 a a+1];
%             near_x=repmat(near_x',1,3);
%             near_x=reshape(near_x,1,[]);
%             near_y=[b-1 b b+1];
%             near_y=repmat(near_y,3,1);
%             near_y=reshape(near_y,1,[]);
%             distance=sqrt((near_x-x(a)).^2+(near_y-y(b)).^2);
%             [nearest_distance,I]=min(distance);
%             h(near_x(I)+1,near_y(I)+1)=max(1-nearest_distance,0);
%     end
% end

for a=1:2:num_pixel
        r_x=round(x(a));
        r_y=round(y(a));
        near_x=[r_x-1 r_x r_x+1];
        near_x=repmat(near_x',1,3);
        near_x=reshape(near_x,1,[]);
        near_y=[r_y-1 r_y r_y+1];
        near_y=repmat(near_y,3,1);
        near_y=reshape(near_y,1,[]);
        distance=sqrt((near_x-x(a)).^2+(near_y-y(a)).^2);
        distance=reshape(distance,3,3);
        near_x=reshape(near_x,3,3);
        near_y=reshape(near_y,3,3);
%         nearest_distance=
%         [nearest_distance,I]=min(distance);%只有对于0和pi有用，其余角度都没用
%         h(near_x(I)+1,near_y(I)+1)=max(1-nearest_distance,0);

        for b=1:3
            for c=1:3
                h(near_x(b,c)+1,near_y(b,c)+1)=max(1-distance(b,c),0);
            end
        end
end
for a=2:2:num_pixel
        r_x=round(x(a));
        r_y=round(y(a));
        near_x=[r_x-1 r_x r_x+1];
        near_x=repmat(near_x',1,3);
        near_x=reshape(near_x,1,[]);
        near_y=[r_y-1 r_y r_y+1];
        near_y=repmat(near_y,3,1);
        near_y=reshape(near_y,1,[]);
        distance=sqrt((near_x-x(a)).^2+(near_y-y(a)).^2);
        distance=reshape(distance,3,3);
        near_x=reshape(near_x,3,3);
        near_y=reshape(near_y,3,3);
        for b=1:3
            for c=1:3
                if h(near_x(b,c)+1,near_y(b,c)+1)>max(1-distance(b,c),0)
                elseif h(near_x(b,c)+1,near_y(b,c)+1)<=max(1-distance(b,c),0)
                    h(near_x(b,c)+1,near_y(b,c)+1)=max(1-distance(b,c),0);
                end
            end
        end
end


h=h/(sum(h(:)));