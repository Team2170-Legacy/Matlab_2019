function [output] = Find_Calib_Parameters_v001(target_L_img, target_R_img)

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

target_L;

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

target_R;

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

output = Calib;

end

