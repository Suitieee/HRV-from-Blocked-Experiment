function[]=plotWT8(ecg)
%ecgsmooth=ecg-smooth(ecg,200);%eliminate baseline drift
[c,l]=wavedec(ecg,8,'coif4');%wavelettransform
[d1,d2,d3,d4,d5,d6,d7,d8]=detcoef(c,l,[1,2,3,4,5,6,7,8]);

if 1
    figure, 
    ax(1)=subplot(8,1,1);plot(d1(1:10000));axis tight;title('Post_d1');
    ax(2)=subplot(8,1,2);plot(d2(1:5000));axis tight;title('Post_d2');
    ax(3)=subplot(8,1,3);plot(d3(1:2500));axis tight;title('Post_d3');
    ax(4)=subplot(8,1,4);plot(d4(1:2000));axis tight;title('Post_d4');
    ax(5)=subplot(8,1,5);plot(d5(1:1000));axis tight;title('Post_d5');
    ax(6)=subplot(8,1,6);plot(d6(1:500));axis tight;title('Post_d6');
    ax(7)=subplot(8,1,7);plot(d7(1:250));axis tight;title('Post_d7');
    ax(8)=subplot(8,1,8);plot(d8(1:100));axis tight;title('Post_d8');
    axis tight;
end