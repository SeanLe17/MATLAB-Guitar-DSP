% FX_DISTORT
% Soft-clipping distortion using tanh waveshaping.
% Inputs: x (signal), drive, level
% Output: y_out
function y_out = fx_distort(x, drive, level);
   x_gain = drive*x;
   y_out = tanh(x_gain);
   y_out * level;
   y_out(y_out>0.99) = 0.99;
   y_out(y_out<-0.99) = -0.99;
end