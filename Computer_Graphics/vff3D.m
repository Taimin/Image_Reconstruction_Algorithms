function im = vff3D

%   This is a modification of the program described below

% %   This program can be used to open micro-CT VFF file in Matlab.
% %   
% %   Shanrong Zhang, 12/17/2004
% %   Department of Radiology, 
% %   University of Washington
% %   zhangs@u.washington.edu
% %

%   This alows 2D cross sections to be obtained from a 3D cube of data.
%   Easy modification will alow you to input 3D data into MatLAB from vff
%   files. Enjoy.

%   Samuel Lawman, 25/07/2008
%   School of Science and Technology
%   Nottingham Trent University


[filename pathname] = uigetfile('*.vff','Please select a vff file');

fid = fopen([pathname filename],'r','b');

disp(filename)

num = 0;
done = false;

frame = 0;

line = fgetl(fid);
disp(line);
while (~isempty(line) && ~done)
    line = fgetl(fid);
    disp(line);
    if strmatch('size=', line)
        [token, rem] = strtok(line,'size= ;');
        M(1) = str2num(token);
        [token,rem] = strtok(rem);
        M(2) = str2num(token);
        M(3) = str2num(strtok(rem,' ;'));
    end
    
    if strmatch('bits=', line)
        bits = str2num(strtok(line,'bits=;'));
    end
    
    num = num + 1;
    
    if num >= 14
        done = true;
    end
end
ask = input(['Floating Point or Interger Data Type? (F/I)'],'s')
if ask == 'I'
    enctyp = 'int'
else
    enctyp = 'float'
end

while (frame < 1) | frame > M(3)
fprintf(['\nWhich Frame number do you wish to see? 1-' num2str(M(3)) '\n'],'s')
frame = input(['Frame?'])

end

status = fseek(fid, -((M(1)).*(M(2)).*(M(3)).*bits./8) + (frame-1)*M(1).*M(2).*bits./8,'eof');



im = fread(fid,[M(1),M(2)],[enctyp num2str(bits)]);
% figure;
% imshow(im,[]); 
% colormap(gray);
% title(filename); 

fclose(fid);

% end of code

