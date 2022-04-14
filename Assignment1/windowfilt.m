
clc;
clear all;
close all;

%Reading the audio file, Fs sampling frequency, y sample number and double
%channel
[y,Fs] = audioread("group12.wav");

% time domin
t = linspace(0,length(y)/Fs,length(y));
figure;
plot(t,y);
title('time domain');
xlabel('time(s)');
ylabel('amplitude');

Length_audio = length(y);
df=Fs/Length_audio;
frequency_audio=-Fs/2:df:Fs/2-df;

figure
FFT_audio_in=fftshift(fft(y))/length(fft(y));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

bst = fir1(1000,[0.037 0.048],"stop");

outst = filter(bst,1,y);

subplot(2,1,1)
plot(t,y)
title('Original Signal')
ys = ylim;

subplot(2,1,2)
plot(t,outst)
title('Notch Filtered Signal')
xlabel('Time (s)')
ylim(ys)

fvtool(bst, "Fs", Fs)

figure
FFT_audio_in=fftshift(fft(outst))/length(fft(outst));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of output Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

filename = 'filtered.wav';
audiowrite('filtered.wav', outst, Fs);

%freqz(bst,1,512)

%b = fir1(100,[0.4 0.41]);
%freqz(b,1,512)

%ord = 100;

%low = 0.4;
%bnd = [0.7 0.71];

%bM = fir1(ord,[low bnd]);

%bW = fir1(ord,[low bnd],'DC-1');

%hfvt = fvtool(bM,1,bW,1);
%legend(hfvt,'bM','bW')




%load chirp

%t = (0:length(y)-1)/Fs;



%bst = fir1(34,[0.48 0.5],"stop");

%outst = filter(bst,1,y);
%freqz(bst,1,512)
%subplot(2,1,1)
%plot(t,y)
%title('Original Signal')
%ys = ylim;

%subplot(2,1,2)
%plot(t,outst)
%title('Notch Filtered Signal')
%xlabel('Time (s)')
%ylim(ys)

