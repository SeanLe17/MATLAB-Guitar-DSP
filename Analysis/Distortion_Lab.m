[x, Fs] = audioread('guitar2.wav');
if size(x,2) == 2
    x = mean(x, 2); % Converts stereo ---> mono
end
%Distortion
x = 0.9 * x / max(abs(x) + 1e-12); % Scales audio file so max amplitude is 0.9
drive = 1; % Controls distortion
x_gain = drive * x; 
y_dist = tanh(x_gain); % Compresses large amplitudes to 1, causes the distortion
level = 2; % Volume control
y = level * y_dist; 
y(y >  0.99) =  0.99; % Sets max amplitude to 1
y(y < -0.99) = -0.99;



%Tone/Low pass filter
fc = 10000;                  % cutoff frequency in Hz ("Tone knob")
alpha = exp(-2*pi*fc/Fs);   % 1-pole RC-matched coefficient based on cutoff
                            %frequency
y_filt = zeros(size(y)); % Creates an array and fills it with zeros (placeholder)
y_filt(1) = y(1); % Initial conditions
for n = 2:length(y)
    y_filt(n) = alpha*y_filt(n-1) + (1-alpha)*y(n);
end % Smooths out curve (Most of previous output + some of the new output)
% Low pass b/c slow changes (low frequencies) are preserved, while fast
% changes (High frequencies) are smoothed out

%-----------------Delay------------------------
delay_time = 0.3;              % seconds of delay (echo happens 0.30s later)
D = round(delay_time * Fs);     % Converts delay time ---> number of samples
y_delay = zeros(size(y_filt));
for n = D+1:length(y_filt)
    y_delay(n) = y_filt(n - D); 
end
mix = 0.35;                         % 0 = no delay, 1 = only delayed signal
y_out = (1-mix)*y_filt + mix*y_delay;
% "Failsafe" so mixing doesn't exceed amplitude 1 and cause clipping
% and distortion


% ===== Reverb (start simple: ONE feedback comb) =====
rev_delay_s1 = 0.037;            % 35 ms (a typical small-room-ish delay)
Drev1 = round(rev_delay_s1 * Fs);

g = 0.8;                        % feedback (decay strength). Keep < 1
rev_mix = 0.8;  
% ============ Comb 1 =================
y_rev1 = zeros(size(y_out));
for n = 1:length(y_out)
    y_rev1(n) = y_filt(n);
    if n > Drev1
        y_rev1(n) = y_rev1(n) + g * y_rev1(n - Drev1);
    end
end
% ============ Comb 2 =================
rev_delay_s2 = 0.041;
Drev2 = round (rev_delay_s2 *Fs);

y_rev2 = zeros(size(y_out));
for n=1:length(y_out)
    y_rev2(n)=y_filt(n);
    if n > Drev2
        y_rev2(n) = y_rev2(n) + g*y_rev2(n-Drev2);
    end
end

% =========== Combining 1 and 2 ===========
y_wet = 0.5*y_rev1 + 0.5*y_rev2;
y_final = (1-rev_mix)*y_filt + rev_mix*y_wet;

sound(y_filt,Fs)


%Graphing
N = round(0.01 * Fs);   % 10 milliseconds
t = (0:N-1) / Fs;
figure;

plot(t, x(1:N), 'b');        % clean input
hold on;
plot(t, y(1:N), 'r');  % distorted output
hold on;
plot(t, y_filt(1:N), 'g');
hold on;
plot(t, y_out(1:N), 'y');
hold off;

legend('Input (clean)', 'After tanh distortion', ' Filtered', "Delay");
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Waveform Before and After Distortion');