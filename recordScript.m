%%
Fs = 16000; % samples/sec
%%
recObj = audiorecorder(Fs, 16, 1);
disp('Press enter, then start speaking.')
pause
secs = 5;
disp('Now recording...')
recordblocking(recObj, 5);
disp('End of Recording.');
pause(0.25);
%%
f = getaudiodata(recObj);
f = f / 4;
play(recObj);
pause(secs);
%%
mult = 1;   % pitch resolution multiplier
T = floor(length(f)/mult);
pluckScript
%%
% Normalize the sound for the audioplayer.
y_pluck = y_pluck-mean(y_pluck);
y_pluck = y_pluck/max(abs(y_pluck));
hplayer = audioplayer(y_pluck, Fs);
play(hplayer)