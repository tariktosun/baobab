%% settings
Fs = 32000; % samples/sec
T = Fs*4;   % samples
L = 1000;  %samples
c = [];
%c = floor(0:(L/2)/T:(L/2))+1;
%c = floor([zeros(1,Fs), 0:(L/2)/(T-Fs):(L/2)])+1;
%c = [ones(1,Fs), ones(1,Fs)*10, ones(1,Fs), ones(1,Fs)*10];
scale = 10; % amplitude multiplier
%% run
y_pluck = myPluck(L, T, [], [], c)*scale;
%% play
hplayer = audioplayer(y_pluck*10, Fs);
play(hplayer)