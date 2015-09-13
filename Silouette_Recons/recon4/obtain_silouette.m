function silouette=obtain_silouette(img)

err=1;
flag=1;
% A=strel('disk',7);
B=strel('disk',5);
C=strel('disk',3);
[m,n]=size(img);
I=false(m,n);
option=0;

while flag~=0
    option=input('Please choose an option: (1) dilate size 5 (2) dialate size 3 (3) erode size 5 (4) erode size 3: ')
    while err~=0
        switch option
            case 1
                
                err=0;
            case 2
                
                err=0;
            case 3
                
                err=0;
                
            case 4
                
                err=0;
                
            otherwise
                disp('Invalid! Please input another value!');
                option=input('Please input another option value: ');
        end
    end
    
    imshow(I);
    flag=input('Is the result acceptable? 1 for YES, 0 for NO');
        err=1;
        while err~=0%防止用户非法输入
            if flag==1
                err=0;
                flag=1;
            elseif flag==0
                err=0;
            else
                flag=input('Invalid! Please input another flag value: ');
            end
        end
end


silouette=I;
end

