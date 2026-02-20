%FX_FILTER
%Low pass filter based on cutoff frequency
%Inputs: x (signal), Fc (Cutoff frequency), Fs (Sampling frequency)
%Outputs: y_out
function y_out = fx_filter(x, Fc, Fs)
    alpha = exp(-2*pi*Fc/Fs); %Converts cutoff frequency ---> mixing factor
    y_out = zeros(size(x));
    y_out(1) = x(1);
    for n = 2:length(y_out)
        y_out(n) = alpha*y_out(n-1) + (1-alpha)*x(n);
    end % Smooths out curve (Most of previous output + some of the new output)
% Low pass b/c slow changes (low frequencies) are preserved, while fast
% changes (High frequencies) are smoothed out
end