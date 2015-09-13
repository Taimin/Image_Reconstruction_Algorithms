%% initial parameters input by users%%
filename_PJ = './Dataset/Zsmall_Proj_53_p69_n69_correct_pad0.mat'; %path of an assembled projections
%filename_PJ = './Dataset/Projections/proj*.*'; %path of projections
PJ_Dimension = 1; %1 an assembled projections; 2 a set of projections;
filename_Theta = './Dataset/dA_wedge53.mat'; %rotation angles
filename_Boundary = './Dataset/Boundary.mat'; %support or start with no support by commenting it out
%filename_InitialObj = '.\Dataset2\InitialObj.mat'; %initial object or start with random initial object by commenting it out  

n = 64; nz = 64; %Size of object where nx = ny = n;
UpdateRate = 10; %Update_rate;
TotalIterations = 100; %Total iterations;
algorithm = 1; %1 Projection-based algorithm; 2 Gradient-based algorithm; 3 Projection-based algorithm without positivity; 4 Gradient-based algorithm without positivity;
colormapping = 1; %Colormap; 1 jet, 2 gray, 3 bone, 4 copper, 5 hot, 6 cool, 7 hsv
array = 1; %1 ArrayWithMinimumError is saved; 2 ArrayOfLastIteration is saved; 
filename_BestObj = './Dataset/Res1.mat'; %where ReconstructionArray is saved;
filename_ErrorArray = './Dataset/Err1.mat';%where ErrorArray is saved



%% Construct initial_pars %%
initial_pars.filename_PJ = filename_PJ;
initial_pars.filename_PJ_Dimension = PJ_Dimension; %1 an assembled projections; 2 a set of projections;
initial_pars.filename_Theta = filename_Theta;
if exist('filename_Boundary','var')
initial_pars.filename_Boundary = filename_Boundary;
end
if exist('filename_InitialObj','var')
initial_pars.filename_InitialObj = filename_InitialObj;
end
initial_pars.n = n;
initial_pars.nz = nz;
initial_pars.UpdateRate = UpdateRate;
initial_pars.TotalIterations = TotalIterations;
initial_pars.algorithm = algorithm;
initial_pars.colormapping = colormapping;
initial_pars.array = array;
%% checkParameters %%
flag = checkParameters(initial_pars);
if flag == 1
error('mod(TotalIterations,UpdateRate) should equal to zero. e.g. TotalIterations=50, UpdateRate=5');    
end
if flag == 2
error('the number of measured projections should equal to the number of rotational angles');    
end
if flag == 3
error('nz is not correct. e.g. PJ(21,95,number), nz=21 or proj001(21,95), nz=21');    
end
if flag == 4
error('size of Boundary is not correct, please check Boundary(n,n,nz)');    
end
if flag == 5
error('size of InitialObj is not correct, please check InitialObj(n,n,nz)')
end
if flag == 6
error('rotational angles and n do not match to form a pseudopolar grid, please check n (even number) or rotational angles (-90<Theta<=90)');
end

if flag == 0
disp('The input parameters look good');
end

%% Read in initial_pars and construct struc_in %%
n = initial_pars.n;
nz = initial_pars.nz;

PJ = My_importdata(initial_pars.filename_PJ,initial_pars.filename_PJ_Dimension);
Theta = importdata(initial_pars.filename_Theta);
Theta = Theta(:);

if isfield(initial_pars,'filename_Boundary')
Boundary = importdata(initial_pars.filename_Boundary);
struct_out.ind_Boundary = find(Boundary<0.5);
else
struct_out.ind_Boundary = [];
end

if isfield(initial_pars,'filename_InitialObj')
struct_out.InitialObj = importdata(initial_pars.filename_InitialObj);
else
struct_out.InitialObj = zeros(n,n,nz);    
end

struct_out.ftSlices = Projections2Slices(PJ,Theta,n,nz);

struct_out.BestObj = zeros(n,n,nz);

clear Boundary PJ Theta;

struct_out.ErrorArray = zeros(initial_pars.TotalIterations,1);
struct_out.UpdateRate = initial_pars.UpdateRate;
struct_out.TotalIterations = initial_pars.TotalIterations;
struct_out.BestError = 1e9;
struct_out.UpdateNum = 1; %The very first time to call  runIterations 
struct_out.n = n;
struct_out.nz = nz;

struct_out.algorithm = initial_pars.algorithm;
struct_out.array = initial_pars.array;
struct_out.colormapping = initial_pars.colormapping;

struct_out = runIterations(struct_out); %The very first time to call  runIterations 

%%  subsequent calls of runIterations%%
nc = struct_out.n/2+1; nzc = floor(struct_out.nz/2)+1; %Central pixels of n and nz
TotalUpdate = round(struct_out.TotalIterations/struct_out.UpdateRate);
for kk = 2:TotalUpdate
struct_out.UpdateNum = kk; %The kk time to call runIterations 
struct_out = runIterations(struct_out);

slice1 = squeeze( struct_out.BestObj(nc,:,:) );
slice2 = squeeze( struct_out.BestObj(:,nc,:) );
slice3 = squeeze( struct_out.BestObj(:,:,nzc) );
pj1 = squeeze( sum(struct_out.BestObj,1) );
pj2 = squeeze( sum(struct_out.BestObj,2) );
pj3 = squeeze( sum(struct_out.BestObj,3) );

h1=figure(1);
set(h1,'Position',[220 378 560 420]);
set(h1,'Color','white');
plot(struct_out.ErrorArray);
title('Error vs iteration');


h2 = figure(2);
switch struct_out.colormapping
case 1
colormap(jet);
case 2
colormap(gray);
case 3
colormap(bone);
case 4
colormap(copper);
case 5
colormap(hot);
case 6
colormap(cool);
case 7
colormap(hsv);    
end
set(h2,'Position',[820 378 560 420]);
set(h2,'Color','white');
subplot(2,3,1);imagesc(slice1);axis equal;
title('Centralslice 1');
subplot(2,3,2);imagesc(slice2);axis equal;
title('Centralslice 2');
subplot(2,3,3);imagesc(slice3);axis equal;
title('Centralslice 3');
subplot(2,3,4);imagesc(pj1);axis equal;
title('Projection 1');
subplot(2,3,5);imagesc(pj2);axis equal;
title('Projection 2');
subplot(2,3,6);imagesc(pj3);axis equal;
title('Projection 3');

drawnow;

end

% Save the results
[pathstr1, name1, ext1] = fileparts(filename_BestObj);
[pathstr2, name2, ext2] = fileparts(filename_ErrorArray);
switch struct_out.array
case 1    
eval([name1 '=struct_out.BestObj;']);
case 2
eval([name1 '=struct_out.InitialObj;']);
end
eval([name2 '=struct_out.ErrorArray;']);

eval(['save' ' ''' filename_BestObj ''' ' name1]);
eval(['save' ' ''' filename_ErrorArray ''' ' name2]);
