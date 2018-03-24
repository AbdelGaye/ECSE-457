function f = keypointsfindmatch_func(image1, image2)

%% Step 1: Read Images
% Read the reference image containing the object of interest.
boxImage = imread(image1);
%boxImage = rgb2gray(temp1);
% figure;
% imshow(boxImage);
% title('Image 1 (box)');

%%
% Read the target image containing a cluttered scene.
sceneImage = imread(image2);
%sceneImage = rgb2gray(temp2);
% figure; 
% imshow(sceneImage);
% title('Image 2 (cluttered)');

%% Step 2: Detect Feature Points
% Detect feature points in both images.
boxPoints = detectSURFFeatures(boxImage);
scenePoints = detectSURFFeatures(sceneImage);

%% Step 3: Extract Feature Descriptors
% Extract feature descriptors at the interest points in both images.
[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

%% Step 4: Find Putative Point Matches
% Match the features using their descriptors. 
boxPairs = matchFeatures(boxFeatures, sceneFeatures);
matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);

save info.mat;

