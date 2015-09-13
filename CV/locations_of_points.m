
load('webcamsSceneReconstruction.mat');

I1 = imread('sceneReconstructionLeft.jpg');
I2 = imread('sceneReconstructionRight.jpg');

faceDetector = vision.CascadeObjectDetector;
face1 = step(faceDetector,I1);
face2 = step(faceDetector,I2);

center1 = face1(1:2) + face1(3:4)/2;
center2 = face2(1:2) + face2(3:4)/2;

point3d = triangulate(center1, center2, stereoParams);
distanceInMeters = norm(point3d)/1000;

distanceAsString = sprintf('%0.2f meters', distanceInMeters);
I1 = insertObjectAnnotation(I1,'rectangle',face1,distanceAsString,'FontSize',18);
I2 = insertObjectAnnotation(I2,'rectangle',face2, distanceAsString,'FontSize',18);
I1 = insertShape(I1,'FilledRectangle',face1);
I2 = insertShape(I2,'FilledRectangle',face2);

imshowpair(I1, I2, 'montage');