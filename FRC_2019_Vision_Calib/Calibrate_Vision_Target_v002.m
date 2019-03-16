%   Calibrate_Vision_Target_v002.m
%   Written on 3/15/2019
%   Jacob Krucinski (jacob1576@gmail.com)
clc;
close all;
clear all;

img_001_path = 'Images/pingu.jpg';
img_001 = imread(img_001_path);
imshow(img_001);
% img_001_rotated = imrotate(img_001, 30);
% imshow(img_001_rotated);
while (true)
    k = waitforbuttonpress;
    % 28 leftarrow
    % 29 rightarrow
    % 30 uparrow
    % 31 downarrow
    value = double(get(gcf,'CurrentCharacter'))
    
    if (value == 28)
        img_001 = imrotate(img_001, 2);
    end
    
    if (value == 29)
        img_001 = imrotate(img_001, -2);
    end
    
    imshow(img_001);
end


% Get 4 point of target in order: top left, top right, bottom right, bottom
% left
rect1 = ginput(4);
rounded1 = round(rect1);

% % Find equation of line through points 1 and 2 (vector p)
% x1 = rect1(1,2);
% y1 = rect1(1,1);
% m = (rect1(2,1) - rect1(1,1)) / (rect1(2,2) - rect1(1,2));
% y = m * (x - x1) + y1;
% 
% % Find perpendicular equation of line of the line that passses through points 1 and 2 (normal)
% m_perp = -1/m;



% figure
% imshow(section);