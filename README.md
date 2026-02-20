# MATLAB Guitar DSP Project

This project implements a modular digital guitar effects chain in MATLAB.

## Signal Chain

Distortion → Low-pass Filter → Delay → Reverb

## Implemented DSP Concepts

- Nonlinear waveshaping using `tanh`
- 1-pole IIR low-pass filter
- Feedforward delay line
- Feedback comb reverb
- Dry/wet signal architecture
- Modular function-based DSP structure

## Project Structure


 - main.m
 - fx/
 - fx_distort.m
 - fx_filter.m
 - fx_delay.m
 - fx_reverb.m
 - audio/
 - guitar.wav
 - analysis/


## How to Run

1. Open `main.m`
2. Ensure audio files are in the `audio/` folder
3. Run the script

## Future Improvements

- FFT spectral analysis
- Biquad filters
- Oversampling and aliasing demonstration
- Improved reverb diffusion

---

Created as a self-driven DSP learning project.