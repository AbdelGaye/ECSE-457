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

directory3 = 'G:\CoordinateFiles\';
suffix = '*.dat';
s = strcat(directory3, suffix);
folder3 = dir(s);
%Need to get only the name from folder struct
coords = extractfield(folder3, 'name');

%write header to file
fid = fopen('MatchData.csv','w'); 

for k = 1:1:length(imageset)
%     tic;
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
                dat_im2 = strcat(directory3, string(coords(p)));
                M = transpose(csvread(dat_im2));
                
                for m = 1:1:length(coords)
            
                    check = strsplit(string(coords(m)), '-');
                    check = strsplit(check(2), 'i');
                    check = check(1);
                    check{1}(end) = '';

                    check = strcat(check, '.png');

                    if strcmp(check, imageset(k))

                        current_coord = coords(m);

                        prefix = java.lang.String(coords(m));
                        prefix = prefix.charAt(10);

                        foo_im3 = strcat(directory3, string(coords(m)));
                        foo_im3 = extractAfter(foo_im3, 70);

                        foo_im2 = extractAfter(dat_im2, 70);


                        if strcmp(prefix, '3') && strcmp(foo_im2, foo_im3)
                            dat_im3 = strcat(directory3, string(coords(m)));
                            N = transpose(csvread(dat_im3));
                            
                            break;
                        end

                    end
                end 
            end
        end
%         disp(p);  
%         toc;
    end
    
    disp(dat_im3);
    
    img1 = strcat(directory, imageset(k));
    img2 = strcat(directory2, imageset2(k));

    %Getting the keypoints from the program
    keypointsfindmatch_func(char(img1), char(img2));
    load('info.mat');

    points_img1 = transpose(matchedBoxPoints.Location);
    points_img2 = transpose(matchedScenePoints.Location);

    dataset_size = size(M,2);
    program_size = size(points_img1,2);
    
    %X coordinates of the matched keypoints between dataset and program
    counter = 0;
    mat_dataset = zeros(1, length(dataset_size));
    mat_program = zeros(1, length(dataset_size));
    c = 1;

    coord_program = zeros (1, length(dataset_size));
    coord_dataset = zeros (1, length(dataset_size));

    % Iterating through the dataset keypoints
    for j = 1:1:dataset_size
        % Look through surf points
        for i = 1:1:program_size
            if abs(M(1,j) - points_img1(1,i)) < 16
                % Check if y in dataset is within a value in surf points
                if abs(M(2,j) - points_img1(2,i)) < 16
                    counter = counter + 1;
                    mat_dataset(c) = M(1,j);
                    mat_program(c) = points_img1(1,i);

                    % Storing the corresponding indices
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
        if( abs( N(1, coord_dataset(a)) - points_img2(1, coord_program(a))) < 16)
            matches = matches + 1;
        end
    end
    
    %Matches: Increments when a dataset match is equal to a program match
    %Counter: Incremets when a point from the dataset source image is similar to a point
    %from the program source image
    %Dataset_size: Size of M, number of matches dataset
    
    %Number of matches / number of keypoints that are similar to dataset
    match_accuracy(k) = matches / counter;
    
    %Number of matches / number of matches in dataset
    accuracy(k) = matches / dataset_size;
    
    saveMatrix(1) = dat_im3;
    saveMatrix(2) = match_accuracy(k);
    saveMatrix(3) = accuracy(k);
    
    if(k == 149)
        saveMatrix(4) = mean(match_accuracy);
        saveMatrix(5) = mean(accuracy);
    end
    
    fprintf(fid, '%s,', saveMatrix{1,1:end}) ;
    fprintf(fid, '\n') ;
    
    disp(k);
end

fclose(fid);

