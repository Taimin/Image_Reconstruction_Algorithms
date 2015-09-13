function[img,filter]=FBP2(R,theta,xp,imgRows,imgCols,filter_type)

[N,K]=size(R); %K=# of angles measured
                %N=# of detectors at each angle
xp_offset=abs(min(xp))+1;
width=2^nextpow2(N);%get power of 2 for FFT large enough to fit a column of R to speed up FFT
tmpImg=zeros(imgRows,imgCols);%allocate image for processing values

proj_fft=fft(R,width);

%create the filter in frequency domain
ramlak=2*[0:(width/2-1),width/2:-1:1]'/width;

if(filter_type==0)%no filter, do nothing
    filter=ones(width,1);
elseif(filter_type==1)%Ram-Lak Filter
    filter=ramlak;
elseif(filter_type==2)
    Sinc=abs(sinc(2*(0:width-1)/(2*width)));
    temp=[Sinc(1:(width/2)) Sinc(width/2:-1:1)];
    filter=ramlak.*temp';
elseif(filter_type==3)
    Cosine=abs(cos(2*pi*(0:width-1)/(2*width)));
    filter=ramlak.*Cosine';
elseif(filter_type==4)
    Hamming=0.54-0.46*cos(2*pi*(0:width-1)/width);
    temp=[Hamming(width/2:width) Hamming(1:width/2-1)];
    filter=ramlak.*temp';
elseif(filter_type==5)
    Hann=0.5-0.5*cos(0:(width-1)/width);
    temp=[Hann(width/2:width) Hann(1:width/2-1)];
    filter=ramlak.*temp';
end

%do the filtering
for i=1:K
    filtered(:,i)=proj_fft(:,i).*filter;
end

%perform ifft on product of step 3
proj=real(ifft(filtered));

for(i=1:K)
    Q=proj(:,i); %Get filtered projection for current angle
    rad=theta(i)*pi/180;%convert current angle to radians
    
    for(x=1:imgCol)
        for(y=1:imgRows)
            %Nearest Neighbor on detector
            %t=round((x-128)*cos(rad)-(y-128)*sin(rad))+xp_offset;
            %tmpImg(y,x)=tmpImg(y,x)+Q(t);
            
            %find position on detector
            t=(x-(imgCols/2))*cos(rad)-(y-(imgRows)/2)*sin(rad)+xp_offset;
            %get weighted values from adajcent detector location
            if(ceil(t)==floor(t))
                q1=Q(ceil(t));
                q2=0;
            else
                q1=Q(ceil(t))*(t-floor(t));
                q2=Q(floor(t))*(ceil(t)-t);
            end
            %update current pixel with weighted values.
            tmpImg(y,x)=tmpImg(y,x)+q1+q2;
        end
    end
end

%pi/K from equation 
img=(pi/K)*tmpImg;%reconstruction seems too bright.might need to scale down
            
        
        
        
    