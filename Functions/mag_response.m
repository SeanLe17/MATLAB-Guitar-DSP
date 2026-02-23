function [f, mag_response] = mag_response(x , y, Nfft ,Fs)
%Outputs magnitude response of LPF
%   x = input signal, y = filtered signal 
X = fft(x,Nfft);
Y = fft(y,Nfft);
half = 1:(Nfft/2+1); %Only want half of FFT because the other half is a negative copy
f = (half-1)*(Fs/Nfft); 
eps = 1e-12;
Xmag = abs(X(half))/Nfft;
Ymag = abs(Y(half))/Nfft;
Hmag = Ymag ./(Xmag+eps);
mag_response = 20*log10(Hmag + eps);  
end