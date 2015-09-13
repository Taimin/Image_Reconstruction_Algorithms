%Generate a cubic and display it in isosurface format
volumeX = 64;
volumeY = 128;
volumeZ = 64;
volume = ones(volumeX,volumeY,volumeZ);
for x=20:40
    for y=40:90
        for z=20:40
            volume(x,y,z)=0;
        end
    end
end

[xMesh yMesh zMesh] = meshgrid(1:volumeY,1:volumeX,1:volumeZ);
isosurface(xMesh, yMesh, zMesh, volume, 0.99);
%isonormals(xMesh, yMesh, zMesh, volume, pt);
%set(pt,'FaceColor','red','EdgeColor','none');
daspect([1 1 1]);%Set or query axes data aspect ratio
camlight;%Create or move light object in camera coordinates
lighting gouraud;

view(-90,90);

