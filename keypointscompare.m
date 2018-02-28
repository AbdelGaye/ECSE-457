%Getting the image from the dataset
image1 = '20130614_124600.png';

%Getting the name of the .mat file of that image
tf = strsplit(image1,'.');
matpath = char(strcat(tf(1,1), '_P.mat/'));

% Read the reference image containing the object of interest.
picture = imread(image1);

keyPoints = detectSURFFeatures(picture);

[features, keyPoints] = extractFeatures(picture, keyPoints);

%Sorting the keypoints
%SURF
pin = transpose(keyPoints.Location);
pout = sortrows(pin',1)';

%DATASET
m = matfile(matpath);
tFeatures = m.TFeatures;
tpout = sortrows(tFeatures',1)';

%Initializing the number of correct matches
correctMatches = 0;

k = size(pout,2);
l = size(tpout,2);
%Look through dataset
for j = 1:1:l
    %Look through surf points
    for i = 1:1:k
        %If x in dataset is within a value in surf points
        if abs(tpout(1,j) - pout(1,i)) < 4
            %Check if y in dataset is within a value in surf points
            if abs(tpout(2,j) - pout(2,i)) < 4
                %Increment number of dataset points found by surf if x and
                %y are close
                correctMatches = correctMatches + 1;
                break;
            end    
        end
    end
end

pck = correctMatches / size(tpout,2);

