%nearest interpolation method download from internet, work for black and
%white images
clear;
close all;
H=1;                        %����pix�е�һ��Ԫ�أ����߶�
W=2;                        %����pix�еڶ���Ԫ�أ������
jiaodu=45;                       %Ҫ��ת�ĽǶȣ���ת����Ϊ˳ʱ��
img=imread('image.jpg');       %����vΪԭͼ��ĸ߶ȣ�uΪԭͼ��Ŀ��
img=rgb2gray(img);
imshow(img);                    %����yΪ�任��ͼ��ĸ߶ȣ�xΪ�任��ͼ��Ŀ��
[v u]=size(img);

theta=jiaodu/180*pi;
rot=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1]; 
inv_rot=inv(rot);
pix1=[1 1 1]*rot;               %�任��ͼ�����ϵ������
pix2=[1 u 1]*rot;               %�任��ͼ�����ϵ������
pix3=[v 1 1]*rot;               %�任��ͼ�����µ������
pix4=[v u 1]*rot;               %�任��ͼ�����µ������

height=round(max([abs(pix1(H)-pix4(H))+0.5 abs(pix2(H)-pix3(H))+0.5]));     %�任��ͼ��ĸ߶�
width=round(max([abs(pix1(W)-pix4(W))+0.5 abs(pix2(W)-pix3(W))+0.5]));      %�任��ͼ��Ŀ��
imgn=zeros(height,width);

delta_y=abs(min([pix1(H) pix2(H) pix3(H) pix4(H)]));            %ȡ��y����ĸ��ᳬ����ƫ����
delta_x=abs(min([pix1(W) pix2(W) pix3(W) pix4(W)]));            %ȡ��x����ĸ��ᳬ����ƫ����

for y=1-delta_y:height-delta_y
    for x=1-delta_x:width-delta_x
        pix=[y x 1]*inv_rot;                                %�ñ任��ͼ��ĵ������ȥѰ��ԭͼ�������꣬                                         
                                                            %������Щ�任���ͼ������ص��޷���ȫ���
        if pix(H)>=0.5 && pix(W)>=0.5 && pix(H)<=v && pix(W)<=u
            imgn(y+delta_y,x+delta_x)=img(round(pix(H)),round(pix(W)));
        end   
        
    end
end

figure,imshow(uint8(imgn))