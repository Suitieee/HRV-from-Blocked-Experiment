clc;clear;

%% Loading the namelist of subject
Codepath='E:\ECG\ECGforZhang\ECG_Jiang';
[sublist,cntlist] = Subjectloading(Codepath,'subj.txt');
results=[];

for subj = 1 : length(sublist)%
%% loading file
mat_folder = [Codepath filesep 'VRECG_cleaned'];%'VR_ECG'is not cleaned.
%load .mat data and save ECG as ECGraw
load([mat_folder filesep sublist{subj} '.mat']) 
ECGraw=data(:,2); 
%% loading file(new)
% filename1 = [sublist{subj} '_0101.mat'];
% load(['E:\ECG\ECGforZhang\ECG_Jiang\VRECG_cleaned' filesep filename1]) 
% ECGraw = data(:,2);
% filename2 = [sublist{subj} '_0102.mat'];
% load(['E:\ECG\ECGforZhang\ECG_Jiang\VR_ECG_4.2_cleared' filesep filename2]) 
% ECGraw = [ECGraw ; data(:,2)];
%% downsampling
raw_f = 2000; % 1000Hz for ERP experiment, 2000Hz for blocked experiment
fs = 200;% 200Hz for wavelet transform.
ECGdesample = resample(ECGraw,fs,raw_f);
%% wavelet transform or PT algorithm
gr = 0;% plot or not
RR = [];%
RMSSD = 0;
%PreplotWT8(ECGdesample);
[c,l,d1,d2,d3,d4,d5,d6,d7,ECGclean]=wavelettransform7(ECGdesample);% wavelet transform and noise removal
[qrs_amp_raw,qrs_i_raw,delay,ecg_filter] = PT_algorithm(ECGclean,fs,gr);
%plotWT8(ECGclean);

%% HRV指标自定义
RR = zRR(diff(qrs_i_raw),fs);% select the RRdiff with the z-score between -3 and 3
PNN50 = PNN50ms(RR);% percentage of RRdiff above 50ms

diffRR = diff(RR);
for i = 1 : length(diffRR)
  RMSSD = RMSSD + diffRR(i)^2;
end
RMSSD = (RMSSD/(length(diffRR)-1));
RMSSD = RMSSD ^0.5;
results(subj,1)=RMSSD;% standard deviation of RRdiff
    
end

xlswrite('RMSSD_result03.xlsx',results);
