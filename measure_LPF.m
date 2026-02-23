
% ------- Parameters -------
Fs = 44100;      % sampling rate (Hz)
T  = 5;          % duration (s)
N  = round(Fs*T);

% ------- Input: white noise -------
rng(0);                % "seed" for random number generation
x = randn(N,1);        % fills x with N entries of random numbers
y = fx_filter(x, 400, Fs);
z = fx_filter(x, 800, Fs);

Nfft = 2^nextpow2(length(x)); %Sets number of samples to 
[f,HdbY] = mag_response(x,y,Nfft, Fs);
[f,HdbZ] = mag_response(x,z,Nfft,Fs);

% ----- Plot (zoomed) -----
figure;
plot(f, HdbY);
hold on
plot(f, HdbZ);
hold off
grid on;
xlabel('Frequency (Hz)');
ylabel('|H(f)| (dB)');
title('Estimated LPF magnitude response');
legend('400 Hz cutoff', ' 800 Hz cutoff');
xlim([0 5000]);      % show 0–5 kHz for now
ylim([-80 5]);       % typical display range

