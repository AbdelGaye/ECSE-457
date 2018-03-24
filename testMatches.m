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

counter = 0;
mat_dataset = zeros(1, length(dataset_size));
mat_program = zeros(1, length(dataset_size));
c = 1;

coord_program = zeros (1, length(dataset_size));
coord_dataset = zeros (1, length(dataset_size));

%Iterating through the dataset keypoints
for j = 1:1:dataset_size
    %Look through surf points
    for i = 1:1:program_size
        if abs(M(1,j) - points_img1(1,i)) < 16
                %Check if y in dataset is within a value in surf points
                if abs(M(2,j) - points_img1(2,i)) < 16
                    counter = counter + 1;
                    mat_dataset(c) = M(1,j);
                    mat_program(c) = points_img1(1,i);
                    
                    %Storing the corresponding indices
                    coord_dataset(c) = j;
                    coord_program(c) = i;
                    
                    c = c+1;
                    break;
                end
        end
    end
end

element = 0;
elementN = 0;
matches = 0;

for a = 1:1:size(coord_dataset, 2)
    nval = N(1, coord_dataset(a));
    p_img2 = points_img2(1, coord_program(a));
    if( abs(N(1, coord_dataset(a)) - points_img2(1, coord_program(a)) < 16) )
        matches = matches + 1;
    end
end

match_accuracy = matches / counter;
accuracy = matches / dataset_size;