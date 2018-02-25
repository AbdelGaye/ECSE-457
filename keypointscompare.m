%Sorting the keypoints
%SURF
pin = transpose(scenePoints.Location)

pout = sortrows(pin',1)'

%DATASET
tpout = sortrows(TFeatures',1)'

correctMatches = 0;

k = size(pout,2);
l = size(tpout,2);
%Look through dataset
for j = 1:1:l
    %Look through surf points
    for i = 1:1:k
        %If x in dataset is within a value in surf points
        if abs(tpout(1,j) - pout(1,i)) < 5
            %Check if y in dataset is within a value in surf points
            if abs(tpout(2,j) - pout(2,i)) < 5
                %Increment number of dataset points found by surf if x and
                %y are close
                correctMatches = correctMatches + 1;
                break;
            end    
        end
    end
end

pck = correctMatches / size(tpout,2);

