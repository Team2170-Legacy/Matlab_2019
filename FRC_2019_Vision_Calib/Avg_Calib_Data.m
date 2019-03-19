function [calibOutput] = Avg_Calib_Data(Calib)

nCalibs = size(Calib, 2);

H_min_min = 999;
H_max_max = -999;
S_min_min = 999;
S_max_max = -999;
V_min_min = 999;
V_max_max = -999;

for i=1:nCalibs
    H_min = Calib(i).H_min;
    H_max = Calib(i).H_max;
    S_min = Calib(i).S_min;
    S_max = Calib(i).S_max;
    V_min = Calib(i).V_min;
    V_max = Calib(i).V_max;
    
    if H_min < H_min_min
        H_min_min = H_min;
    end
    
    if H_max > H_max_max
        H_max_max = H_max;
    end
    
    if S_min < S_min_min
        S_min_min = S_min;
    end
    
    if S_max > S_max_max
        S_max_max = S_max;
    end
    
    if V_min < V_min_min
        V_min_min = V_min;
    end
    
    if V_max > V_max_max
        V_max_max = V_max;
    end
    
    
end

avgCalib.H_min = H_min_min;
avgCalib.H_max = H_max_max;
avgCalib.S_min = S_min_min;
avgCalib.S_max = S_max_max;
avgCalib.V_min = V_min_min;
avgCalib.V_max = V_max_max;

calibOutput = avgCalib;
end

