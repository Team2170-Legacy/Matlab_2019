%
%   Graph_RPi_Data.m
%
% Clear workspace first
clc; clear all; close all;

% Call import script
Data=import_RPi('test1.txt');

% Extract timestamp and RPM columns
t = Data.t;
%t = timestamps - timestamps(1)
x_target_error = Data.x_target_error;

% Plot the data (at the end)
figure
stairs(t, x_target_error);
