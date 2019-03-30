%
%   Graph_RPi_Data.m
%
% Clear workspace first
clc; clear all; close all;

top_dir         = pwd;
dirmask_top     = 'Log_*.txt';
dir_content_top = dir( [ top_dir '\' dirmask_top ] );
num_dir_top     = length(dir_content_top);

log_file_name = dir_content_top(num_dir_top).name

% Call import script
Data=import_RPi(log_file_name);

% Extract timestamp and data columns, written in C++ using
% dataLog << "t, x_target_error, distance_to_target, tape_align_error, 
%   target_locked, left_tape_area, right_tape_area\n";

t       = Data.t;
xe      = Data.x_target_error;
d       = Data.distance_to_target;
ae      = Data.tape_align_error;
tl      = Data.target_locked;
lA      = Data.left_tape_area;
rA      = Data.right_tape_area;

% Plot the data (at the end)
f1 = figure;
set(f1, 'DefaultLineLineWidth', 3);

subplot(411)
%stairs(t, x_target_error);
plot(t, xe);
ylabel(mk_str('x_target_error'))
grid on
title(mk_str(log_file_name))

subplot(412)
plot(t, d)
ylabel(mk_str('distance_to_target'))
grid on

subplot(413)
plot(t, ae)
ylabel(mk_str('tape_align_error'))
grid on

subplot(414)
plot(t,tl)
ylabel(mk_str('target_locked'))

xlabel('t')
grid on

fig_name = log_file_name(1:end-4);
saveas(gcf, fig_name, 'fig')
disp('saving figure...')

