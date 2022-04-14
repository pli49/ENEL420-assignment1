clc;
clear all;
close all;


[y,Fs] = audioread("group12.wav");                      %read the file as a signal y and a smapling frequiency Fs

%%
%Task 1
% plot the time domin of the audio signal
t = linspace(0,length(y)/Fs,length(y));                 %number of seconds taken
figure(1);
plot(t,y);
title('time domain');
xlabel('time(s)');
ylabel('amplitude');

%%
%Task 2
%plot the FFT of the audio signal
figure(2)
Length_audio = length(y);                               %number of samples
df=Fs/Length_audio;                                     %Time or space increment per sample
frequency_audio=-Fs/2:df:Fs/2-df;                       %0-centered frequency range
FFT_audio_in=fftshift(fft(y))/length(fft(y));           %Discrete Fourier transform of shifted origonal signal
plot(frequency_audio,abs(FFT_audio_in));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

%%
%Task 3
%Calculate IIR filter
theta = 2*pi*926.664/44100;                             %angle of the pole zero placement
bw = 100;                                               %bandwidth
r = 1-(bw/Fs)*pi;                                       %distance of the poles to centre of the circle
B1 = -2*cos(theta);                                     %x(n-1)
A1 = -r*2*cos(theta);                                   %y(n-1)
A2 = r*r;                                               %y(n-2)            
B = [1,B1 , 1];
A = [1, A1, A2];
N = 1001;                                               %1000 number of coefficients

%%
%Task 4 
%Plot the time domain of the filtered signal
H = filter(B,A,y);                                      %IIR filtered signal
figure(3) 
plot(t,H)
title('time domain');
xlabel('time(s)');
ylabel('amplitude');

%% 
%Task 4 
%Plot the magnitude and phase of the frequency response of the IIR filter
figure(4)
freqz(B,A,N,Fs);                        

%%
%output new filtered audio file IIRfiltered.wav
filename = 'IIRfiltered.wav';
audiowrite('IIRfiltered.wav', H, Fs)

%%
%Task 4
%FFT of the filtered signal
figure(5)
FFT_audio_in2=fftshift(fft(H))/length(fft(H));          %Discrete Fourier transform of shifted and filtered signal
plot(frequency_audio,abs(FFT_audio_in2));               
title('FFT of filtered Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

%%
%SNR calculation for the IIR filter
r = snr(H, y)                                           %SNR = -28.2322 for the IIR filter

