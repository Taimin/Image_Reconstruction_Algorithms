close all;
clear;
%calculate the coordinate in the original image which correspond exactly
%the coordinates in the image after rotation
%�м���Ӧ���Ȱ���ת����ͼ������������ֵ�������Ȼ������ת�����в�ֵ������ֵ���������ת������������
%�����ǽ��������ת����������ߣ�Ȼ������ת�������ߣ���meshgrid���������������Ȼ���ֵ���ٰ����������ת���������Ǵ����
img=imread('image.jpg');
%img=double(img);
[m,n,p]=size(img);

theta=pi/3;
cos_val	= cos(theta);
sin_val	= sin(theta);

%get the size of the box
img_cross_len=round((m^2+n^2)^0.5);
vertice_x=[1 1;m m];
vertice_y=[1 n;1 n];
vertice_x1 = round((vertice_x-m/2)*cos_val - (vertice_y-n/2)*sin_val + img_cross_len/2);
vertice_y1 = round((vertice_x-m/2)*sin_val + (vertice_y-n/2)*cos_val + img_cross_len/2);
vertice_x1_r=reshape(vertice_x1,4,1);
vertice_y1_r=reshape(vertice_y1,4,1);
vertice_x1_min=min(vertice_x1_r);
vertice_x1_max=max(vertice_x1_r);
vertice_y1_min=min(vertice_y1_r);
vertice_y1_max=max(vertice_y1_r);
a=vertice_x1_max-vertice_x1_min+1;
b=vertice_y1_max-vertice_y1_min+1;
img_rotate=uint8(zeros(a,b,3));

%coordinates of points on the corner after rotation, notices: these
%coordinates are in the img_rotate coordination system
p1=[vertice_x1(1,1)-vertice_x1_min+1,vertice_y1(1,1)-vertice_y1_min+1];
p2=[vertice_x1(2,1)-vertice_x1_min+1,vertice_y1(2,1)-vertice_y1_min+1];
p3=[vertice_x1(2,2)-vertice_x1_min+1,vertice_y1(2,2)-vertice_y1_min+1];
p4=[vertice_x1(1,2)-vertice_x1_min+1,vertice_y1(1,2)-vertice_y1_min+1];

%coordinates of the image after rotation��������������������
x0=round(linspace(p1(1),p2(1),m));
y0=round(linspace(p1(2),p2(2),m));
x1=round(linspace(p2(1),p3(1),n));
y1=round(linspace(p2(2),p3(2),n));
% x2=round(linspace(p4(1),p3(1),n));
% y2=round(linspace(p4(2),p3(2),n));
% x3=round(linspace(p1(1),p4(1),n));
% y3=round(linspace(p1(2),p4(2),n));

%coordinates of the pixels after inverse rotation��˳ʱ����ת������
x0_IR=(x0-a/2)*cos_val+(y0-b/2)*sin_val+m/2;
y0_IR=-(x0-a/2)*sin_val+(y0-b/2)*cos_val+n/2;
x1_IR=(x1-a/2)*cos_val+(y1-b/2)*sin_val+m/2;
y1_IR=-(x1-a/2)*sin_val+(y1-b/2)*cos_val+n/2;

%[X,Y]=meshgrid(1:m,1:n);
%[Xq,Yq]=meshgrid(y1_IR,x0_IR);%������дͼ��ͻ���ת��ʮ�ȣ������
Xq=repmat(x0_IR',1,n);%meshgridҲ���ԣ�����дҲ�У���OK
Yq=repmat(y1_IR,m,1);
Vq=uint8(zeros(m,n,3));

%rotate the x_IR pixels again by the same angle
X = uint32((Xq-m/2)*cos_val - (Yq-n/2)*sin_val + a/2);	
Y = uint32((Xq-m/2)*sin_val + (Yq-n/2)*cos_val + b/2);

for i=1:3
   Vq(:,:,i)=interp2(img(:,:,i),Yq,Xq,'nearest'); %һ��Ҫ��Yq��Xq��д����Ҫ��Ȼ������ԣ��������ת��ʮ�ȵ�
end

%assign the value in Vq to img_rotate

for i=1:m  
   for j=1:n
       img_rotate(X(i,j),Y(i,j),:)=Vq(i,j,:);
   end
end


figure, imshow(img);
figure, imshow(img_rotate);
% for i=1:m
%     for j=1:m
%         img_rotate(i,j,:)=img
%     end
% end
