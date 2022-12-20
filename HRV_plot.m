clc;clear;

%% load namelist of subjects
Codepath='E:\ECG\ECGforZhang\ECG_Jiang';

%% load file
filename = 'NNstd123.xlsx';
data = xlsread(['E:\ECG\ECGforZhang\ECG_Jiang' filesep filename]) ;
ratio01 = data(:,1);
ratio02 = data(:,2);
ratio03 = data(:,3);
%% boxplot
figure
group = [ repmat('Pre_NNstd', size(ratio01,1), 1); repmat('Stimulating_NNstd', size(ratio03,1), 1);repmat('Post_NNstd', size(ratio02,1), 1)];
boxplot([ratio01;ratio03;ratio02],group)