function [calibOutput] = Avg_Calib_Data(Calib)

nCalibs = size(Calib, 2);

H_min_sum = 0;
H_max_sum = 0;
S_min_sum = 0;
S_max_sum = 0;
V_min_sum = 0;
V_max_sum = 0;

for i=1:nCalibs
    H_min_sum = H_min_sum + Calib(i).H_min;
    H_max_sum = H_max_sum + Calib(i).H_max;
    S_min_sum = S_min_sum + Calib(i).S_min;
    S_max_sum = S_max_sum + Calib(i).S_max;
    V_min_sum = V_min_sum + Calib(i).V_min;
    V_max_sum = V_max_sum + Calib(i).V_max;
end

avgCalib.H_min = H_min_sum / nCalibs;
avgCalib.H_max = H_max_sum / nCalibs;
avgCalib.S_min = S_min_sum / nCalibs;
avgCalib.S_max = S_max_sum / nCalibs;
avgCalib.V_min = V_min_sum / nCalibs;
avgCalib.V_min = V_max_sum / nCalibs;

calibOutput = avgCalib;
end

