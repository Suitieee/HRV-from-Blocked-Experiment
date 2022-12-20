clc;clear;

%% load namelist of subjects
Codepath='E:\ECG\ECG_Jiang';
[sublist,cntlist] = Subjectloading(Codepath,'subj.txt');

for subj = 1 : length(sublist)
%% loadfile
mat_folder = [Codepath filesep 'data'];
%load .mat data and save ECG as ECGraw
load([mat_folder filesep sublist{subj} '.mat']) 
ECGraw=acq.data(:,2); 

%% loadfile
% filename1 = [sublist{subj} '_0101.mat'];
% load(['E:\ECG\ECGforZhang\ECG_Jiang\VRECG_cleaned' filesep filename1]) 
% ECGraw = data(:,2);
% filename2 = [sublist{subj} '_0102.mat'];
% load(['E:\ECG\ECGforZhang\ECG_Jiang\VR_ECG_4.2_cleared' filesep filename2]) 
% ECGraw = [ECGraw ; data(:,2)];
%% downsampling
raw_f = 1000;
fs = 200;
ECGdesample = resample(ECGraw,fs,raw_f);
%% wavelet transform or PT algorithm
gr = 0;% plot or not
results = [];
RR = [];

%PreplotWT8(ECGdesample);
[c,l,d1,d2,d3,d4,d5,d6,d7,ECGclean]=wavelettransform7(ECGdesample);% wavelet transform and noise removal
[qrs_amp_raw,qrs_i_raw,delay,ecg_filter] = PT_algorithm(ECGclean,fs,gr);
%plotWT8(ECGclean);

% plot
% figure,az(1)=subplot(211);plot(ecg_filter);title('QRS on Filtered Signal');
% hold on,scatter(qrs_i_raw,qrs_amp_raw,'r');
% az(1)=subplot(212);plot(ECGdesample);title('Raw ECG');axis tight;

RR = zRR(diff(qrs_i_raw),fs);
PNN50 = PNN50ms(RR);
[LF,HF,LFHFratio] = spectral_analysis_HRV(RR,fs,'spline');% frequency features

results(1,:)=qrs_i_raw;
results(2,:)=qrs_amp_raw;
results(3,1:length(RR))=RR;
results(4,1:length(RR))=60./RR;
results(5,1)= mean(RR);
results(6,1)= std(RR);
results(7,1)= PNN50;
results(8,1)=LF;%0.04~0.15Hz
results(9,1)=HF;%0.15~0.4Hz
results(10,1)=LFHFratio;
    
% xlswrite([sublist{subj} '_result.xlsx'],results)  
xlswrite([sublist{subj} 'result.xlsx'],results)
% xlswrite([sublist{subj} '_0201_0202_result.xlsx'],results)

end
