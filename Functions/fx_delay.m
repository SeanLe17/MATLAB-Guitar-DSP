% FX_DELAY
% Inputs: x (signal), delay_time, mix, Fs)
% Outputs: y_out
function y_out = fx_delay(x, delay_time, mix, Fs)

    D = round(delay_time * Fs);
    y_delay = zeros(size(x));

    for n = D+1:length(x)
        y_delay(n) = x(n-D);
    end

    y_out = (1-mix)*x + mix*y_delay;

end