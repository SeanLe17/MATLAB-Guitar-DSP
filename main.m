addpath(genpath(pwd));
Fs = 8000;

[x, Fs] = audioread('guitar2.wav');
if size(x,2) == 2
    x = mean(x, 2); % Converts stereo ---> mono
end
x = 0.9 * x / max(abs(x) + 1e-12); % Scales audio file so max amplitude is 0.9


%==============Signal chain==================%
y1 = fx_distort(x,5,0.5);
y2 = fx_filter(y1, 400, Fs );
y3 = fx_delay(y2,0,0.5,Fs);
y4 = fx_reverb(y3, 0.9, 0.9, Fs);


sound(y4, Fs)



%===============Graphing===========================

Nfft = round(0.05*Fs);
xSeg = x(1:Nfft);
y1Seg = y1(1:Nfft);

X = fft(xSeg);
Y1 = fft(y1Seg);



magX = abs(X)/Nfft;             
magXc = magX(1:Nfft/2+1);  
magY1 = abs(Y1)/Nfft;             
magY1c = magY1(1:Nfft/2 +1);     

f = (0:Nfft/2)*(Fs/Nfft);         
  
figure;
plot(f,magXc);
xlim([0,2000]);
hold on
plot(f, magY1c);
hold off
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT magnitude of a 440 Hz sine');
legend('Clean', ' Distorted');




%{
N = round(0.01 * Fs);   % 10 milliseconds
t = (0:N-1) / Fs;
plot(t, x(1:N), 'b');        % clean input
hold on;
plot(t, y1(1:N), 'r');  % distorted output
hold on;
plot(t, y2(1:N), 'g');
hold on;
plot(t, y3(1:N), 'y');
hold on;
plot(t, y4(1:N), 'p');
hold off
legend('Clean', 'Distorted', ' Filtered', " Delay", " Reverb");
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Waveform Before and After Distortion');
%}
