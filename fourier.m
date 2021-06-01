function [f_vals, absol] = fourier(x, t)
L = length(t);
f_vals= 48000 * (-L/2:L/2-1)/L;
length(f_vals);

fourier = fftshift(fft(x)/L);
absol = abs(fourier);
length(absol)
absol(468865:length(x)) = [];
end

