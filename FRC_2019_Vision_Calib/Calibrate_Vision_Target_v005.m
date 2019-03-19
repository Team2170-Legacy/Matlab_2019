%   Calibrate_Vision_Target_v005.m
%   Written on 3/15/2019
%   Jacob Krucinski (jacob1576@gmail.com)

%% Init
S;

%% Ask user if they are calibrating floor lines or vision target
target_type = input('Calibration of 1 - Floor Lines, 2 - Vision Target\n');
numImgs = input('How many images do you have?\n');
startImg = input('Start image ID\n');

%% Load in all images first
if target_type == 2
    for i=startImg:numImgs
        img_path = strcat('Calibration_Images_2019_03_16/00', num2str(i), '.PNG');
        img = imread(img_path);

        % Rotate the image so that vision targets are straight up and down
        img = imrotate(img, 14.5);
        % Invert colors so that ginput cross hairs are more visible
        imshow(uint8(255) - img);

        % Use ginput to grab specific target (add code support for 2)
        disp('Click in the upper left and then the lower right of the reflective tape...');
        rectL = ginput(2);
        roundedL = round(rectL);

        disp('Click in the upper left and then the lower right of the reflective tape...');
        rectR = ginput(2);
        roundedR = round(rectR);

        % Get target subsections from ginput
        target_L_img = img( roundedL(1,2):roundedL(2,2) , roundedL(1,1):roundedL(2,1), : ); % x then y
        target_R_img = img( roundedR(1,2):roundedR(2,2) , roundedR(1,1):roundedR(2,1), : ); % x then y

        % Show target subsections in separate windows
        figure('Name', img_path, 'NumberTitle', 'off'); hold on;
        imshow(target_L_img);
        figure('Name', img_path, 'NumberTitle', 'off'); hold on;
        imshow(target_R_img);
        
        % Find Calib values
        % Use i in order to have all images as their own structs of data
        index = (i - startImg) + 1;
        Calib(index) = Find_Calib_Parameters_v001(target_L_img, target_R_img)
    end

else
    for i=startImg:numImgs
        img_path = strcat('Calibration_Images_2019_03_16/00', num2str(i), '.PNG');
        img = imread(img_path);
        figure('Name', img_path, 'NumberTitle', 'off')
        imshow(img);
        
        % Use ginput to grab specific target (add code support for 2)
        disp('Click in the upper left and then the lower right of the floor line...');
        line = ginput(2);
        roundedLine = round(line);
        
        % Get target subsections from ginput
        target_L_img = img( roundedLine(1,2):roundedLine(2,2) , roundedLine(1,1):roundedLine(2,1), : ); % x then y
        
        % Show target subsections in separate windows
        figure; hold on;
        imshow(target_L_img);
        
        % Find Calib values
        % Use i in order to have all images as their own structs of data 
        target_R_img = target_L_img;
        index = (i - startImg) + 1;
        Calib(index) = Find_Calib_Parameters_v001(target_L_img, target_R_img)
    end
end

% Take the average of Calib parameters from each image


%% Now write .h file
if target_type==1
    Calibration_Data_Make_h_File_v002(Calib, 'FloorLines_Calibration.h');
else % target_type == 2
    Calibration_Data_Make_h_File_v002(Calib, 'VisionTarget_Calibration.h');
end
