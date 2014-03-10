Fs = 16000;
y_pluck = myPluck(40, Fs*4)*10;
hplayer = audioplayer(y_pluck*10, Fs);
play(hplayer)