%��������ת����ͼ����������Ȼ����ת���õ�����С������������ͨ��˫���Բ�ֵ���С���������ϵ���ֵ
close all;
clear;
%���΢����һ���ɣ�����ڷ�����Ϊ�õ���תǰ��������round�����Գ�������ڷ�
%������ת����������е����궼ȡ���ˣ����ԣ����õ�������ת����ȱ���ص�����

img=imread('image.jpg');
[m,n,p]=size(img);

%������ת����
theta=2*pi/3;
cos_val=cos(theta);
sin_val=sin(theta);
R=[cos_val,-sin_val;sin_val,cos_val];
R_inv=[cos_val,sin_val;-sin_val,cos_val];

%��ԭͼ�����Ͻǣ�1,1��Ϊ��ת���ģ������ת��ͼ���ĸ����������
vertice_X=[1 1 m m];
vertice_Y=[1 n 1 n];
Rot_vertice_X=R(1,:)*[(vertice_X-1);(vertice_Y-1)];
Rot_vertice_Y=R(2,:)*[(vertice_X-1);(vertice_Y-1)];

%����ĸ�������Χ�ɵľ��ε�����
%��������õ���ͼ���������
m1=max(Rot_vertice_X)-min(Rot_vertice_X)+1;
n1=max(Rot_vertice_Y)-min(Rot_vertice_Y)+1;

Rot_img=uint8(zeros(round(m1),round(n1),3));

% for indexX=1:round(m1)%�ٶ�̫�������٣�������
%     for indexY=1:round(n1)
%         X1=indexX-round(abs(min(Rot_vertice_X)));%�õ���ͼ�������
%         Y1=indexY-round(abs(min(Rot_vertice_Y)));
%         Xoo=R_inv(1,:)*[X1;Y1];
%         Yoo=R_inv(2,:)*[X1;Y1];
%         Xo=round(Xoo);
%         Yo=round(Yoo);
%         if 1<Xo&&Xo<m&&1<Yo&&Yo<n%����ڷ�
%             Rot_img(indexX,indexY,:)=img(Xo,Yo,:);
%         end
% 
%     end
% end
indexX=1:round(m1);
indexY=1:round(n1);
[indexX,indexY]=meshgrid(indexX,indexY);
indexX=reshape(indexX',1,[]);
indexY=reshape(indexY',1,[]);
% X1=indexX-ceil(abs(m1/2));%�õ���ͼ�������
% Y1=indexY-ceil(abs(n1/2));
X1=indexX+round(min(Rot_vertice_X));%��Ҫ������任��ʹ��ת�������ת��ͼƬ�����ϽǱ任����תǰͼƬ�����Ͻ�
Y1=indexY+round(min(Rot_vertice_Y));%��ת�任��ԭͼ���Ͻǵĵ�λ��������ϵ�е�λ�ÿ����û�ͼ��ȷ��
Xoo=R_inv(1,:)*[X1;Y1];
Yoo=R_inv(2,:)*[X1;Y1];
Xo=round(Xoo);
Yo=round(Yoo);
% Xo=find(Xo>1 & Xo<m);
% Yo=find(Yo>1 & Yo<n);
Xo=reshape(Xo,round(m1),round(n1));
Yo=reshape(Yo,round(m1),round(n1));
for indexX=1:round(m1)
     for indexY=1:round(n1)
        if Xo(indexX,indexY)>=1&&Xo(indexX,indexY)<=m && Yo(indexX,indexY)>=1 &&Yo(indexX,indexY)<=n %����ڷ�
            Rot_img(indexX,indexY,:)=img(Xo(indexX,indexY),Yo(indexX,indexY),:);
        end
     end
end

imshow(Rot_img);


