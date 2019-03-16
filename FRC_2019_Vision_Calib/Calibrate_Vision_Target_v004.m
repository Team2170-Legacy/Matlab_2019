%   Calibrate_Vision_Target_v003.m
%   Written on 3/15/2019
%   Jacob Krucinski (jacob1576@gmail.com)

%% Init
clc;
close all;
clear all;

%% Ask user if they are calibrating floor lines or vision target
target_type = input('Calibration of 1 - Floor Lines, 2 - Vision Target\n')

%% Load in all images first
if target_type == 2
    img_1_path = 'Calibration_Images_2019_03_16/004.PNG';
    img_1 = imread(img_1_path);
    
    % Rotate the image so that vision targets are straight up and down
    img_1 = imrotate(img_1, 14.5);
    % Invert colors so that ginput cross hairs are more visible
    imshow(uint8(255) - img_1);
    
    % Use ginput to grab specific target (add code support for 2)
    disp('Click in the upper left and then the lower right of the reflective tape...');
    rectL = ginput(2);
    roundedL = round(rectL);
    
    disp('Click in the upper left and then the lower right of the reflective tape...');
    rectR = ginput(2);
    roundedR = round(rectR);
    
    % Get target subsections from ginput
    target_L_img = img_1( roundedL(1,2):roundedL(2,2) , roundedL(1,1):roundedL(2,1), : ); % x then y
    target_R_img = img_1( roundedR(1,2):roundedR(2,2) , roundedR(1,1):roundedR(2,1), : ); % x then y
    
    % Show target subsections in separate windows
    figure; hold on;
    imshow(target_L_img);
    figure; hold on;
    imshow(target_R_img);
else
    img_1_path = 'Calibration_Images_2019_03_16/006.PNG';
    img_1 = imread(img_1_path);
    % Invert colors so that ginput cross hairs are more visible
    imshow(img_1);
    
    % Use ginput to grab specific target (add code support for 2)
    disp('Click in the upper left and then the lower right of the floor line...');
    line = ginput(2);
   	roundedLine = round(line);
    
    % Get target subsections from ginput
    target_L_img = img_1( roundedLine(1,2):roundedLine(2,2) , roundedLine(1,1):roundedLine(2,1), : ); % x then y
    
    % Show target subsections in separate windows
    figure; hold on;
    imshow(target_L_img);
end

%% Now find all parameters needed for the img pipeline
% Parameters to calculate:
% 1. Width, height, and area
% 2. HSV Values (min, max, and avg)
H_margin = 5;
S_margin = 10;
V_margin = 20;


% Target_L
target_L.h      = size(target_L_img, 1);
target_L.w      = size(target_L_img, 2);
target_L.area   = target_L.h * target_L.w;

hsv_target_L = rgb2hsv(target_L_img);

target_L.H = (hsv_target_L(:,:,1) * 360) / 2;   % An array of all 'H' values in rgb target_L image, mult. by 359 due to 0-1 range for H
target_L.S = hsv_target_L(:,:,2) * 255;         % An array of all 'S' values in rgb target_L image, mult. by 100 for percent
target_L.V = hsv_target_L(:,:,3) * 255;         % An array of all 'V' values in rgb target_R image, mult. by 100 for percent

target_L.H_min = min(min(target_L.H));
target_L.H_max = max(max(target_L.H));
target_L.H_avg = mean(mean(target_L.H));
target_L.S_min = min(min(target_L.S));
target_L.S_max = max(max(target_L.S));
target_L.S_avg = mean(mean(target_L.S));
target_L.V_min = min(min(target_L.V));
target_L.V_max = max(max(target_L.V));
target_L.V_avg = mean(mean(target_L.V));

target_L

% Target_R
target_R_img = target_L_img;

target_R.h      = size(target_R_img, 1);
target_R.w      = size(target_R_img, 2);
target_R.area   = target_R.h * target_R.w;

hsv_target_R = rgb2hsv(target_R_img);

target_R.H = (hsv_target_R(:,:,1) * 360) / 2;   % An array of all 'H' values in rgb target_R image, mult. by 359 due to 0-1 range for H
target_R.S = hsv_target_R(:,:,2) * 255;         % An array of all 'S' values in rgb target_R image, mult. by 100 for percent
target_R.V = hsv_target_R(:,:,3) * 255;         % An array of all 'V' values in rgb target_R image, mult. by 100 for percent

target_R.H_min = min(min(target_R.H));
target_R.H_max = max(max(target_R.H));
target_R.H_avg = mean(mean(target_R.H));
target_R.S_min = min(min(target_R.S));
target_R.S_max = max(max(target_R.S));
target_R.S_avg = mean(mean(target_R.S));
target_R.V_min = min(min(target_R.V));
target_R.V_max = max(max(target_R.V));
target_R.V_avg = mean(mean(target_R.V));

target_R

% Calib
Temp_H_min      = min(target_L.H_min, target_R.H_min) - H_margin;
Temp_H_max      = max(target_L.H_max, target_R.H_max) + H_margin;
Temp_S_min      = min(target_L.S_min, target_R.S_min) - S_margin;
Temp_S_max      = max(target_L.S_max, target_R.S_max) + S_margin;
Temp_V_min      = min(target_L.V_min, target_R.V_min) - V_margin;
Temp_V_max      = max(target_L.V_max, target_R.V_max) + V_margin;

Calib.H_min      = max(0, min(180, Temp_H_min));    % Cap values between 0-180 or 0-255
Calib.H_max      = max(0, min(180, Temp_H_max));
Calib.S_min      = max(0, min(255, Temp_S_min));
Calib.S_max      = max(0, min(255, Temp_S_max));
Calib.V_min      = max(0, min(255, Temp_V_min));
Calib.V_max      = max(0, min(255, Temp_V_max));

Calib

%% Now write .h file
if target_type==1
    Calibration_Data_Make_h_File_v002(Calib, 'FloorLines_Calibration.h');
else % target_type == 2
    Calibration_Data_Make_h_File_v002(Calib, 'VisionTarget_Calibration.h');
end
