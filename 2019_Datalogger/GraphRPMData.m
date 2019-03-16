% Clear workspace first
clc; clear all; close all;

% Call import script
ImportRPMData();

% Extract timestamp and RPM columns
timestamps = Data.Timestamp_ms_;
t = timestamps - timestamps(1)
RPMs = Data.RPM;

% Plot the data (at the end)
figure
hold on
plot(t, RPMs);

% Calculate errors
maxRPM = 5600;
commandedSpeed = 0.1;
desiredRPM = maxRPM * commandedSpeed;
error = abs(desiredRPM - RPMs)
avgError = mean(error)