Fs = 8000;                  
N  = Fs;                    
t  = (0:N-1)/Fs;  

x1 = sin(2*pi*440*t);
x2 = sin(2*pi*1000*t);
x3 = sin(2*pi*700*t);
x = x1 + x2 + x3;

X = fft(x);                 

mag = abs(X)/N; % divide by N because FFT scales with N            

mag1 = mag(1:N/2+1); %FFT contains half positive frequencies and half negative copies  

f = (0:N/2)*(Fs/N); %N/2 steps at length of each frequency bin      

figure;
plot(f, mag1);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT magnitude of a 440 Hz sine');
%xlim([0 2000]);