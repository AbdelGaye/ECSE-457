directory = 'CoordinateFiles\';
suffix = '*.dat';
s = strcat(directory, suffix);
folder3 = dir(s);
%Need to get only the name from folder struct
coords = extractfield(folder3, 'name');


for p = 1:1:length(coords)

    current_coord = strsplit(string(coords(p)), 'SIFT');
    current_coord = strsplit(current_coord(1), 'Rat');
    current_coord = current_coord(2);
    ratio = sscanf(current_coord, '%i');
    if ratio < 200
        fileToDelete = strcat(directory, char(coords(p)));
        delete(fileToDelete);
    end
end