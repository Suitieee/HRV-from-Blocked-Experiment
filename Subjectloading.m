function [sublist,cntlist]=Subjectloading(Codepath,filename)

subjlist = [Codepath filesep filename];% initialize
fid = fopen(subjlist); 
sublist = {}; cntlist = 1;% initialize
while ~feof(fid)
    linedata = textscan(fgetl(fid), '%s', 'Delimiter', '\t');% initialize
    sublist(cntlist,:) = linedata{1}; 
    cntlist = cntlist + 1; %#ok<*SAGROW>
end
fclose(fid);
addpath (genpath (Codepath));