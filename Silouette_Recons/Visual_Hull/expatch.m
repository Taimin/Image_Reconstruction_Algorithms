%Create a square patch with red face color and black edges using x- and y-coordinates:
x = [0 1 1 0];
y = [0 0 1 1];
figure,patch(x,y,'red')

%Create a square patch with red face color and black edges using vertices and faces:
vert = [0 0;1 0;1 1;0 1]; % x and y vertex coordinates
fac = [1 2 3 4]; % vertices to connect to make square
figure,patch('Faces',fac,'Vertices',vert,'FaceColor','red')

%Specify colors for each vertex and interpolate the face color:
fvc = [1 0 0;0 1 0;0 0 1;0 0 0];%RGB value
figure,c=patch('Faces',fac,'Vertices',vert,'FaceVertexCData',fvc,'FaceColor','interp');