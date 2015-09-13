function [im] = vff
%   This program can be used to open micro-CT VFF file in Matlab.
%   
%   Shanrong Zhang, 12/17/2004
%   Department of Radiology, 
%   University of Washington
%   zhangs@u.washington.edu
%

[filename pathname] = uigetfile('*.vff','Please select a fdf file');

fid = fopen([pathname filename],'r','b');

disp(filename)

num = 0;
done = false;

line = fgetl(fid);
disp(line);
while (~isempty(line) && ~done)
    line = fgetl(fid);
    disp(line);
    if strmatch('size=', line)
        [token, rem] = strtok(line,'size= ;');
        M(1) = str2num(token);
        M(2) = str2num(strtok(rem,' ;'));
    end
    
    if strmatch('bits=', line)
        bits = str2num(strtok(line,'bits=;'));
    end
    
    num = num + 1;
    
    if num >= 14
        done = true;
    end
end
status = fseek(fid, -M(1)*M(2)*bits/8,'eof');
im = fread(fid,[M(1),M(2)],'int16');
figure;
imshow(im,[]); 
colormap(gray);
title(filename); 

fclose(fid);

% end of code
