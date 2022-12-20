% RRdiff is the difference of R Peaks, while sampling rate is 200Hz
function [RR]=zRR(RRdiff,fs)    
    j = 0;
    RRz = zscore(RRdiff);% z-score of RRdiff
    for i = 1:length(RRz)
        if RRz(i) < 3 && RRz (i) > -3
        RR(i-j) = RRdiff(i)/fs;
        else
        j = j + 1;
        end
    end