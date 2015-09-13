%The cascade object detector uses the Viola-Jones algorithm to detect 
%people's faces, noses, eyes, mouth, or upper body. 
%You can also use the Training Image Labeler to train a custom classifier 
%to use with this System object.

%Create a detector object.
    faceDetector = vision.CascadeObjectDetector;
%Read input image.
    I = imread('visionteam.jpg');
%Detect faces.
    bboxes = step(faceDetector, I);
%Annotate detected faces.
   IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
   figure, imshow(IFaces), title('Detected faces');
   
   
%Create a detector object and set properties.
   bodyDetector = vision.CascadeObjectDetector('UpperBody');
   bodyDetector.MinSize = [60 60];
   bodyDetector.MergeThreshold = 10;
%Read input image and detect upper body.
   I2 = imread('visionteam.jpg');
   bboxBody = step(bodyDetector, I2);
%Annotate detected upper bodies.
   IBody = insertObjectAnnotation(I2, 'rectangle',bboxBody,'Upper Body');
   figure, imshow(IBody), title('Detected upper bodies');