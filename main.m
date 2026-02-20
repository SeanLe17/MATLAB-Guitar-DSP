addpath(genpath(pwd));
[x, Fs] = audioread('guitar2.wav');
if size(x,2) == 2
    x = mean(x, 2); % Converts stereo ---> mono
end
x = 0.9 * x / max(abs(x) + 1e-12); % Scales audio file so max amplitude is 0.9

%==============Signal chain==================%
y1 = fx_distort(x,5,0.5);
y2 = fx_filter(y1, 200, Fs );
y3 = fx_delay(y2,0.03,0.5,Fs);
y4 = fx_reverb(y3, 0.7, 0.85, Fs);


sound(y4, Fs)



%===============Graphing===========================
N = round(0.01 * Fs);   % 10 milliseconds
t = (0:N-1) / Fs;
figure;

plot(t, x(1:N), 'b');        % clean input
hold on;
plot(t, y1(1:N), 'r');  % distorted output
hold on;
plot(t, y2(1:N), 'g');
hold on;
plot(t, y3(1:N), 'y');
hold on;
plot(t, y4(1:N)), 'p';
hold off
legend('Clean', 'Distorted', ' Filtered', " Delay", " Reverb");
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Waveform Before and After Distortion');