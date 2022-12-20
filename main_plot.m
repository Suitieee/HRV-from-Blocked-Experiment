clc;clear;

%% load namelist of subjects
Codepath='E:\ECG\ECGforZhang\ECG_Jiang';
[sublist,cntlist] = Subjectloading(Codepath,'subj.txt');

%% loadfile
mat_folder = [Codepath filesep 'VRECG_cleaned'];
%load .mat data and save ECG as ECGraw
load([mat_folder filesep '01-03.mat']) 
ECGraw1=data(:,2); 
%% loadfile
filename1 = '01_0101.mat';
load(['E:\ECG\ECGforZhang\ECG_Jiang\VRECG_cleaned' filesep filename1]) 
ECGraw2 = data(:,2);
filename2 = '01_0102.mat';
load(['E:\ECG\ECGforZhang\ECG_Jiang\VR_ECG_4.2_cleared' filesep filename2]) 
ECGraw2 = [ECGraw2 ; data(:,2)];
%% down sampling
raw_f = 2000; 
fs = 200;
ECGdesample1 = resample(ECGraw1,fs,raw_f);
ECGdesample2 = resample(ECGraw2,fs,raw_f);
%% wavelet transform of PT algorithm
gr = 0;% plot or not
results = [];
RR = [];

%PreplotWT8(ECGdesample);
[c,l,d1,d2,d3,d4,d5,d6,d7,ECGclean1]=wavelettransform7(ECGdesample1);% wavelet transform and noise removal
[qrs_amp_raw1,qrs_i_raw1,delay1,ecg_filter1] = PT_algorithm(ECGclean1,fs,gr);
%plotWT8(ECGclean);

[C,L,D1,D2,D3,D4,D5,D6,D7,ECGclean2]=wavelettransform7(ECGdesample2);% wavelet transform and noise removal
[qrs_amp_raw2,qrs_i_raw2,delay2,ecg_filter2] = PT_algorithm(ECGclean2,fs,gr);

figure,
az(1)=subplot(211);plot(ecg_filter1);title('stimulated');
hold on,scatter(qrs_i_raw1,qrs_amp_raw1,'r');
az(1)=subplot(212);plot(ecg_filter2);title('Resting state');
hold on,scatter(qrs_i_raw2,qrs_amp_raw2,'r');
axis tight;


