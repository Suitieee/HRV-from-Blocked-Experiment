function[c,l,d1,d2,d3,d4,d5,d6,d7,cleanecg]=wavelettransform7(ecg)
ecgsmooth=ecg-smooth(ecg,200);% eliminate baseline drift
[c,l]=wavedec(ecgsmooth,7,'db4');% wavelettransform
[d1,d2,d3,d4,d5,d6,d7]=detcoef(c,l,[1,2,3,4,5,6,7]);

[thr,sorh,keepapp]=ddencmp('den','wv',ecgsmooth);% filter the signals
% THR is the threshold of the function
% SORH is the way how function select the threshold, soft when sorh is s, hard when sorh is h
% KEEPAPP decide whether process the Approximate component with the threshold, 1 or 0

cleanecg=wdencmp('gbl',c,l,'db6',7,thr,sorh,keepapp);%œ˚‘Î—πÀı
% db4 wavelet£¨gb1 means process the signals with same threshold in each layer.