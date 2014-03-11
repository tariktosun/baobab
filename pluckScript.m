%% settings
Fs = 44100; % samples/sec
T = Fs*4;   % samples
Fdes = 440; % string desired base length
mult = 1;   % pitch resolution multiplier
L = round(mult*Fs/(Fdes));  % sample length of string
c = [];
%c = floor(0:(L/2)/(T*mult):(L/2))+1;
%c = floor([zeros(1,Fs), 0:(L/2)/(T-Fs):(L/2)])+1;
%c = [ones(1,Fs), ones(1,Fs)*10, ones(1,Fs), ones(1,Fs)*10];
%%
%omega = 300;
%f = [sin( (2*pi*omega/(mult*Fs))*(0:(T/2)*mult) ), sin( (2*pi*2*omega/(mult*Fs))*(0:(T/2)*mult) )];
%
x = zeros(1,T*mult);
%%
scale = 10; % amplitude multiplier
%% run
y_pluck = myPluck(L, T, [], x, c, y_pluck, mult);
%% play
hplayer = audioplayer(y_pluck*10, Fs);
play(hplayer)