%% Object Detection in a Cluttered Scene Using Point Feature Matching
% This example shows how to detect a particular object in a cluttered scene,
% given a reference image of the object. 

%% Overview
% This example presents an algorithm for detecting a specific object based 
% on finding point correspondences between the reference and the target 
% image. It can detect objects despite a scale change or in-plane 
% rotation. It is also robust to small amount of out-of-plane rotation and 
% occlusion.
%
% This method of object detection works best for objects that exhibit
% non-repeating texture patterns, which give rise to unique feature matches. 
% This technique is not likely to work well for uniformly-colored objects, 
% or for objects containing repeating patterns. Note that this algorithm is
% designed for detecting a specific object, for example, the elephant in 
% the reference image, rather than any elephant. For detecting objects of a
% particular category, such as people or faces, see |vision.PeopleDetector| 
% and |vision.CascadeObjectDetector|.

% Copyright 1993-2014 The MathWorks, Inc. 

%% Step 1: Read Images
% Read the reference image containing the object of interest.
temp1 = imread('house3.png');
%boxImage = rgb2gray(temp1);
boxImage = temp1;
figure;
imshow(boxImage);
title('Image 1 (box)');

%%
% Read the target image containing a cluttered scene.
temp2 = imread('house4.png');
%sceneImage = rgb2gray(temp2);
sceneImage = temp2;
figure; 
imshow(sceneImage);
title('Image 2 (cluttered)');

%% Step 2: Detect Feature Points
% Detect feature points in both images.
boxPoints = detectSURFFeatures(boxImage);
scenePoints = detectSURFFeatures(sceneImage);

%% 
% Visualize the strongest feature points found in the reference image.
figure; 
imshow(boxImage);
title('100 Strongest Feature Points from Box Image');
hold on;
plot(selectStrongest(boxPoints, 100));

%% 
% Visualize the strongest feature points found in the target image.
figure; 
imshow(sceneImage);
title('300 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 300));

%% Step 3: Extract Feature Descriptors
% Extract feature descriptors at the interest points in both images.
[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

%% Step 4: Find Putative Point Matches
% Match the features using their descriptors. 
boxPairs = matchFeatures(boxFeatures, sceneFeatures);

%% 
% Display putatively matched features. 
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

%% Step 5: Locate the Object in the Scene Using Putative Matches
% |estimateGeometricTransform| calculates the transformation relating the
% matched points, while eliminating outliers. This transformation allows us
% to localize the object in the scene.

%Original code
[tform, inlierBoxPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

%My getInliers
% [inlierBoxPoints, inlierScenePoints] = ...
%      getInliers(matchedBoxPoints, matchedScenePoints, 'affine');
 
 %TODO delete
 tform = 0;

%%
% Display the matching point pairs with the outliers removed
figure;
showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');

%% Step 7: Detect Another Object
% Detect a second object by using the same steps as before.

%%
% Read an image containing the second object of interest.
temp3 = imread('house3.png');
%elephantImage = rgb2gray(temp3);
elephantImage = temp3;
figure;
imshow(elephantImage);
title('Image 3 (elephant)');

%% 
% Detect and visualize feature points.
elephantPoints = detectSURFFeatures(elephantImage);
figure;
imshow(elephantImage);
hold on;
plot(selectStrongest(elephantPoints, 100));
title('100 Strongest Feature Points from Elephant Image');

%%
% Extract feature descriptors.
[elephantFeatures, elephantPoints] = extractFeatures(elephantImage, elephantPoints);

%% 
% Match Features
elephantPairs = matchFeatures(elephantFeatures, sceneFeatures, 'MaxRatio', 0.9);


%%
% Display putatively matched features.
matchedElephantPoints = elephantPoints(elephantPairs(:, 1), :);
matchedScenePoints = scenePoints(elephantPairs(:, 2), :);
figure;
showMatchedFeatures(elephantImage, sceneImage, matchedElephantPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

%% 
% Estimate Geometric Transformation and Eliminate Outliers
%Original code
[tform, inlierElephantPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedElephantPoints, matchedScenePoints, 'affine');

%My getInliers
% [tform, inlierBoxPoints, inlierScenePoints] = ...
%      getInliers(matchedBoxPoints, matchedScenePoints, 'affine');
 
figure;
showMatchedFeatures(elephantImage, sceneImage, inlierElephantPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');
