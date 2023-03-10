%% HRV from:https://github.com/Tereshchenkolab/HRV/blob/master/HRV_full/spectral_analysis_HRV.m
%   type set as none defaultly
function [LF,HF,LFHFratio] = spectral_analysis_HRV(RR,Fs,type)
%spectral_analysis_HRV Spectral analysis of HRV.
%   The function uses FFT to compute the spectral density function of the
%   interpolated RR tachogram.
%
% Input:
%   RR: RR intervals in seconds.
%   Fs: Sampling frequency.
%   type: interpolation type (default: 'spline') 
%
% Output:
%   LF: Low frequency Power
%   HF: High frequency Power
%   LFHFratio: LF/HF
     
    %nargin, Number of function input arguments
    if nargin<2 || isempty(Fs)
        error('wrong number or types of arguments');
    end 
    
    % 数据输入不够3个
    if nargin<3
        type = 'spline';
    end
    
    RR = RR(:); %Convert to column vector
    
    switch type
        case 'none'
            RR_rsmp = RR;
        otherwise
            if sum(isnan(RR))==0 && length(RR)>1
                ANN = cumsum(RR)-RR(1);                         % regenerating time-points
                RR_rsmp = interp1(ANN,RR,0:1/Fs:ANN(end),type); % resampling
            else
                RR_rsmp = [];
            end
    end
    
    % FFT
    % Find length
    L = length(RR_rsmp); 
    
    if L == 0 
        LFHFratio = NaN;
        LF = NaN;
        HF = NaN;
    else
        %nextpow2找到2的高次幂中比L长度大的数
        NFFT = 2^nextpow2(L);             % number of samples for performing fft
        %zscore是z分数，返回NFFT长度的DFT离散傅里叶转换
        Y = fft(zscore(RR_rsmp),NFFT)/L;
        %只考虑前一部分的频段。linspace生成线性间距向量（1/（NFFT/2+1））
        f = Fs/2*linspace(0,1,NFFT/2+1);  % Consider only first half of frequency spectrum 
                                          % as second half is the mirror of 1st half  

        YY = 2*abs(Y(1:NFFT/2+1));%只取前一半，并且乘以2
        YY = YY.^2;
        
        LF = sum(YY(f>0.04 & f<=0.15));  
        HF = sum(YY(f>0.15 & f<=0.4));
        
                                                  
        %plot(f,YY) 
  
        LFHFratio = LF/HF; 
    end
end