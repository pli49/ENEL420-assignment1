clc;
clear all;
close all;

load chirp
y = y + randn(size(y))/25;
t = (0:length(y)-1)/Fs;

f = [0 0.35 0.45 0.50 0.6 1];
mhi = [1 1 0 0 1 1];
bhi = fir2(100,f,mhi);

freqz(bhi,1,[],Fs)

outhi = filter(bhi,1,y);

figure
subplot(2,1,1)
plot(t,y)
title('Original Signal')
ylim([-1.2 1.2])

subplot(2,1,2)
plot(t,outhi)
title('Higpass Filtered Signal')
xlabel('Time (s)')
ylim([-1.2 1.2])