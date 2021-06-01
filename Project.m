clear all;
filename1 = 'Saad.mp3';
filename2 = 'MAM.mp3';
filename3 = 'Ryan.mp3';
filename4 = 'Makhan.mp3';

info = audioinfo(filename1);
[x1,Fs] = audioread(filename1);
[x2,Fs] = audioread(filename2);
[x3,Fs] = audioread(filename3);
[x4,Fs] = audioread(filename4);

info;
T = 1/Fs;
t = 0:T:9.7680;
t = t(1:end-1);
%figure(1);plot(x1);
%figure(2);plot(x2);
%figure(3);plot(x3);
%figure(4);plot(x4);

L1 = length(t);

%[f_vals1, absol1] = fourier(x1,t);
%figure(5);plot(f_vals1, absol1);

%[f_vals2, absol2] = fourier(x2,t);
%figure(6);plot(f_vals2, absol2);

%[f_vals3, absol3] = fourier(x3,t);
%figure(7);plot(f_vals3, absol3);

%[f_vals4, absol4] = fourier(x4,t);
%figure(8);plot(f_vals4, absol4);

t1=0:(10/449998):10;

lpf = LPF;
y1_t = filter(lpf, x1);
y2_t = filter(lpf, x2);
y3_t = filter(lpf, x3);
y4_t = filter(lpf, x4);

y1_t(450000:495984) = [];
y2_t(450000:486768) = [];
y3_t(450000:486768) = [];
y4_t(450000:504048) = [];

%length(y1_t)
%length(y2_t)
%length(y3_t)
%length(y4_t)
%length(t1)

t1 = transpose(t1);

modulated_sig_1 = (y1_t) .* cos(2*pi*3000 * t1);
modulated_sig_2 = (y2_t) .* cos(2*pi*9000 * t1);
modulated_sig_3 = (y3_t) .* cos(2*pi*15000 * t1);
modulated_sig_4 = (y4_t) .* cos(2*pi*21000 * t1);

%figure(9);plot(modulated_sig_1);
%figure(10);plot(modulated_sig_2);
%figure(11);plot(modulated_sig_3);
%figure(12);plot(modulated_sig_4);

mux = modulated_sig_1 + modulated_sig_2 + modulated_sig_3 + modulated_sig_4;

%length(t1)
%length(mux)
%figure(13);title('MUX Plot');plot(t1,mux);

bp_3k = bp_3kHz;
bp_9k = bp_9kHz;
bp_15k = bpp_15kHz;
bp_21k = bp_21kHz;

fil_mux_3k = filter(bp_3k, mux);
fil_mux_9k = filter(bp_9k, mux);
fil_mux_15k = filter(bp_15k, mux);
fil_mux_21k = filter(bp_21k, mux);

%figure(14);plot(fil_mux_3k);title('Band Pass Filter 3kHz');
%figure(15);plot(fil_mux_9k);title('Band Pass Filter 9kHz');
%figure(16);plot(fil_mux_15k);title('Band Pass Filter 15kHz');
%figure(17);plot(fil_mux_21k);title('Band Pass Filter 21kHz');

fil_demux_3k = (fil_mux_3k) .* cos(2*pi*3000*t1);
fil_demux_9k = (fil_mux_9k) .* cos(2*pi*9000*t1);
fil_demux_15k = (fil_mux_15k) .* cos(2*pi*15000*t1);
fil_demux_21k = (fil_mux_21k) .* cos(2*pi*21000*t1);

final1 = filter(lpf,fil_demux_3k);
final2 = filter(lpf,fil_demux_9k);
final3 = filter(lpf,fil_demux_15k);
final4 = filter(lpf,fil_demux_21k);

final1 = 10 * final1;
final2 = 5 * final2;
final3 = 50 * final3;
final4 = 30 * final4;
% Add amplitude
%figure(18);plot(final1);title('Final Track1');
%figure(19);plot(final2);title('Final Track2');
%figure(20);plot(final3);title('Final Track3');
%figure(21);plot(final4);title('Final Track4');

audiowrite('FinalTrack1.wav', final4, Fs);
[y_final,Fs]=audioread('FinalTrack1.wav');
player1 = audioplayer(y_final, Fs);
play(player1)