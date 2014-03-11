%% settings
%{
Fs = 16000; % samples/sec
T = Fs*4;   % samples
mult = 1;   % pitch resolution multiplier
%}
%%
Fdes = 440; % string desired base length
L = round(mult*Fs/(Fdes));  % sample length of string
c = [];
%c = floor(0:(L/2)/(T*mult):(L/2))+1;
%c = floor([zeros(1,Fs), 0:(L/2)/(T-Fs):(L/2)])+1;
%c = [ones(1,Fs), ones(1,Fs)*10, ones(1,Fs), ones(1,Fs)*10];
x = zeros(1,T*mult);
%%
%omega = 300;
%f = 10*[sin( (2*pi*omega/(mult*Fs))*(0:(T/2)*mult) ), sin( (2*pi*2*omega/(mult*Fs))*(0:(T/2)*mult) )];
%%
scale = 10; % amplitude multiplier
%% run
y_pluck = myPluck(L, T, [], x, c, f, mult);
%% play
%hplayer = audioplayer(y_pluck*10, Fs);
%play(hplayer)