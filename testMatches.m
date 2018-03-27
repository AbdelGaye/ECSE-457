%Getting the keypoints from the dataset
directory = 'G:\image_2\';
suffix = '*10.png';
s = strcat(directory, suffix);
folder = dir(s);
%Need to get only the name from folder struct
imageset = extractfield(folder, 'name');

directory2 = 'G:\image_3\';
s = strcat(directory2, suffix);
folder2 = dir(s);
%Need to get only the name from folder struct
imageset2 = extractfield(folder2, 'name');

directory = 'G:\CoordinateFiles\';
suffix = '*.dat';
s = strcat(directory, suffix);
folder3 = dir(s);
%Need to get only the name from folder struct
coords = extractfield(folder3, 'name');

for k = 1:1:length(imageset)
    
    for p = 1:1:length(coords)
        
        check = strsplit(string(coords(p)), '-');
        check = strsplit(check(2), 'i');
        check = check(1);
        check{1}(end) = '';
        
        check = strcat(check, '.png');
        
        if strcmp(check, imageset(k))
            
            current_coord = coords(p);
            
            prefix = java.lang.String(coords(p));
            prefix = prefix.charAt(10);
            
            if strcmp(prefix, '2') 
                dat_im2 = strcat(directory, string(coords(p)));
                M = transpose(csvread(dat_im2));
            end
            
        end
        
        for m = 1:1:length(coords)
            
            check = strsplit(string(coords(p)), '-');
            check = strsplit(check(2), 'i');
            check = check(1);
            check{1}(end) = '';

            check = strcat(check, '.png');

            if strcmp(check, imageset(k))

                current_coord = coords(p);

                prefix = java.lang.String(coords(p));
                prefix = prefix.charAt(10);
                
                foo_im3 = strcat(directory, string(coords(p)));
                foo_im3 = extractAfter(foo_im3, 73);
                
                foo_im2 = extractAfter(dat_im2, 73);
                
                
                if strcmp(prefix, '3') && strcmp(foo_im2, foo_im3)
                    dat_im3 = strcat(directory, string(coords(p)));
                    N = transpose(csvread(dat_im3));
                end
            
            end
        end 
           
    end

%     img1 = strcat(directory, imagetset(k));
%     img2 = strcat(directory, imageset2(k));
% 
%     Getting the keypoints from the program
%     keypointsfindmatch_func(img1, img2);
%     load('info.mat');
% 
%     points_img1 = transpose(matchedBoxPoints.Location);
%     points_img2 = transpose(matchedScenePoints.Location);
% 
%     dataset_size = size(M,2);
%     program_size = size(points_img1,2);
% 
%     counter = 0;
%     mat_dataset = zeros(1, length(dataset_size));
%     mat_program = zeros(1, length(dataset_size));
%     c = 1;
% 
%     coord_program = zeros (1, length(dataset_size));
%     coord_dataset = zeros (1, length(dataset_size));
% 
%     Iterating through the dataset keypoints
%     for j = 1:1:dataset_size
%         Look through surf points
%         for i = 1:1:program_size
%             if abs(M(1,j) - points_img1(1,i)) < 16
%                     Check if y in dataset is within a value in surf points
%                     if abs(M(2,j) - points_img1(2,i)) < 16
%                         counter = counter + 1;
%                         mat_dataset(c) = M(1,j);
%                         mat_program(c) = points_img1(1,i);
% 
%                         Storing the corresponding indices
%                         coord_dataset(c) = j;
%                         coord_program(c) = i;
% 
%                         c = c+1;
%                         break;
%                     end
%             end
%         end
%     end
% 
%     element = 0;
%     elementN = 0;
%     matches = 0;
% 
%     for a = 1:1:size(coord_dataset, 2)
%         nval = N(1, coord_dataset(a));
%         p_img2 = points_img2(1, coord_program(a));
%         if( abs(N(1, coord_dataset(a)) - points_img2(1, coord_program(a)) < 16) )
%             matches = matches + 1;
%         end
%     end
% 
%     match_accuracy = matches / counter;
%     accuracy = matches / dataset_size;
%     
end

