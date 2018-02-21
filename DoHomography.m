%Uncomment for all matched points
pin = transpose(matchedElephantPoints.Location);
pout = transpose(matchedScenePoints.Location);

%Uncomment for inlier
% pin = transpose(inlierElephantPoints.Location);
% pout = transpose(inlierScenePoints.Location);

if size(pin, 2) > size(pout, 2)
    pin = pin(:,1:(end-(size(pin, 2) - size(pout, 2))));
    
    disp(size(pin));
end
if size(pin, 2) < size(pout, 2)
    pout = pout(:,1:(end-(size(pout, 2) - size(pin, 2))));
    
    disp(size(pout));
end

% pin = [127,443,979,1174;255,144,207,196]
% pout = [331,367,1017,714;255,159,202,171]

h = homography_solve(pin, pout);
%h = [7,2,1;0,3,-1;-3,4,-2];
%h = [.1,.1,.01;.1,.1,.1;-0.928366065025330,-0.5,-.1];
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
Image = imread('1.png');
imOut = imwarp(Image, t);
figure
imshow(imOut);