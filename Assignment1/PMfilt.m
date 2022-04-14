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

f = [0 0.395 0.4 0.42 0.425 1];
a = [1 1 0 0 1 1];
b = firpm(500,f,a);

[h,w] = freqz(b,1,512);
plot(f,a,w/pi,abs(h))
legend('Ideal','firpm Design')
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude'



outst = filter(b,1,y);

fvtool(b, "Fs", Fs)

figure
FFT_audio_in=fftshift(fft(outst))/length(fft(outst));
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of output Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

filename = 'filtered.wav';
audiowrite('filtered.wav', outst, Fs);