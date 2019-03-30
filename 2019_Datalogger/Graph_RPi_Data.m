%
%   Graph_RPi_Data.m
%
% Clear workspace first
clc; clear all; close all;

% Call import script
Data=import_RPi('test2.txt');

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
