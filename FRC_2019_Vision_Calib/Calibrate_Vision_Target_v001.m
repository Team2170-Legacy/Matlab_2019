%   Calibrate_Vision_Target.m
%   Updated on 3/15/2019
%   Jacob Krucinski (jacob1576@gmail.com)
clc;
close all;
clear all;

img_001 = imread('Images/TestImage.PNG');
imshow(img_001);

rect1 = ginput(4);
% BW = roipoly(img_001, r, c);
% 
% figure, imshow(BW)
% [R C] = size(BW)
% 
% for i=1:R
%     for j=1:C
%         if BW(i,j)==1
%             Out(i,j) = img_001(i,j);
%         else
%             Out(i,j) = 0;
%         end
%     end
% end
% 
% figure;
% imshow(Out,[]); title('Output Section');

rounded1 = round(rect1)

figure
imshow(section);