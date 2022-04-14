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


d = designfilt('bandstopiir','FilterOrder',2,'HalfPowerFrequency1',900,'HalfPowerFrequency2',950,'DesignMethod','butter','SampleRate',Fs);
fvtool(d,'Fs',Fs)

buttLoop = filtfilt(d,y);

plot(t,y,t,buttLoop)
ylabel('Voltage (V)')
xlabel('Time (s)')
title('Open-Loop Voltage')
legend('Unfiltered','Filtered')
grid

filename = 'filtered.wav';
audiowrite('filtered.wav', buttLoop, Fs);

Length_audio = length(buttLoop);
df=Fs/Length_audio;
frequency_audio=-Fs/2:df:Fs/2-df;

figure
FFT_audio_in=fftshift(fft(buttLoop))/length(fft(buttLoop));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of output Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');
