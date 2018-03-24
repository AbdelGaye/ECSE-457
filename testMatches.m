%Getting the keypoints from the dataset
im2 = 'coords.dat';
M = transpose(csvread(im2));

im3 = 'coords_img3.dat';
N = transpose(csvread(im3));

img1 = 'image_2/000000_10.png';
img2 = 'image_3/000000_10.png';

%Getting the keypoints from the program
keypointsfindmatch_func(img1, img2);
load('info.mat');

points_img1 = transpose(matchedBoxPoints.Location);
points_img2 = transpose(matchedScenePoints.Location);

dataset_size = size(M,2);
program_size = size(points_img1,2);

correctmatches = 0;

%Iterating through the dataset keypoints
for j = 1:1:dataset_size
    %Look through surf points
    for i = 1:1:program_size
        if abs(M(1,j) - points_img1(1,i)) < 15
                %Check if y in dataset is within a value in surf points
                if abs(M(2,j) - points_img1(2,i)) < 15
                    correctmatches = correctmatches+1;
                end
        end
    end
end