% RR is the difference betwwen P peaks with the unit(s).
function [PNN50]=PNN50ms(RR)

    RRdiffdiff = abs(diff(RR));
    NN50 = 0;
    for i = 1: length(RRdiffdiff)
        if RRdiffdiff(i) > (50/1000)
            NN50 = NN50 +1;
        end
    end
    PNN50 = NN50 / length(RRdiffdiff);