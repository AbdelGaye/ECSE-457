%Getting the matrix from the dataset
h = validation.model;
A = transpose(h);  %Your matrix in here
%A = double(A);
%B = full(A);
whos A;

if ~isnumeric(A)
    disp('Not numeric')
end

if ~islogical(A)
    disp('Not logical')
end

if issparse(A)
    disp('sparse')
end

t = projective2d(A);
Image = imread('adamB.png');
imOut = imwarp(Image, t);
figure
imshow(imOut);
