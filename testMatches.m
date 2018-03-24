im2 = 'coords.dat';
M = csvread(im2);

im3 = 'coords_img3.dat';
N = csvread(im3);

img1 = 'image_2/000000_10.png';
img2 = 'image_3/000000_10.png';

%Getting the keypoints from the program
keypointsfindmatch_func(img1, img2);
keypoints = load('info.mat');


%Getting the size of M and N