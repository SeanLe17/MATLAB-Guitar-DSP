% FX_Reverb
% 2 Combs with tail isolation
% Inputs: x (signal), g (tail coefficient), mix, Fs (Sampling frequency)
% Outputs: y_out
function y_out = fx_reverb(x, g, mix, Fs)
    delay1 = 0.037; %Delay times
    delay2 = 0.041;

    Drev1 = round(delay1 * Fs); %Converting delay ms ---> number of samples
    Drev2 = round(delay2 * Fs);

    y1 = x;
    y2 = x;
    for n=Drev1+1:length(y1) %Loops from first sample after delay1 ms
        y1(n) = y1(n) + g *y1(n-Drev1); %Dry sample + small delay "tail"
    end
    
    for n=Drev2+1:length(y2)
        y2(n) = y2(n) + g * y2(n-Drev2);
    end
    y1_tail = y1 - x; %Removes dry signal
    y2_tail = y2 - x;
    y_wet = 0.5*y1_tail + 0.5*y2_tail;
    y_out = x + mix*y_wet; %Mixes wet and dry
        
end