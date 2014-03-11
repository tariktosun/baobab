function y = myPluck(L,S,r,x,c,f,mult,viz)
% y = pluck(L,S,r,x,c,viz)   Plucked string synthesis via pair of waveguide 'rails'
%    L is the length of each waveguide in samples.  
%    S is the number of output samples to produce (default 10000).
%    r is the refelection FIR at the far end (default [-.25 -.5 -.25] if empty)
%    x is optional initial shape to plucked string (triangular by default)
%      if x is a scalar value, it is taken as the pluck point as a
%      proportion of the string length (default 0.5).
%    c is the time-varying clamp location.  Defaults to L for all time.
%    f is the time-varying forcing function
%    mult is the pitch resolution multiplier
%    viz if present and nonzero plots waves & string at each samfple time.

% Written by Tarik Tosun.  Based heavily on 2001 code from columbia.
% 2001-02-01 dpwe@ee.columbia.edu.  Based on Julius Smith's 1992 CMJ paper.
% $Header: /q/pink/home/pink/dpwe/public_html/resources/matlab/RCS/pluck.m,v 1.1 2001/02/21 19:19:56 dpwe Exp $

%% Input handling
% Assign default values:
if nargin < 2
  S = 10000;
end
if nargin < 3 | length(r) == 0
  r = [-.25 -.5 -.25];
end
if nargin < 4 | length(x) == 0
  x = 0.5;
end
if nargin < 5 | length(c) == 0
    c = ones(1,S*mult); % the nut is at index 1.
end
if nargin < 6 | length(f) == 0
    f = zeros(1,S*mult);
end
if nargin < 7 | length(mult) == 0
    mult = 1;
end
if nargin < 8
  viz = 0;
end

%% initialization
% where to read output from - residual at bridge in this case
pickup = L;
% where to apply forcing function
forceLoc = round(L/2);

% Is r a filter or a mid-point?
if length(r) == 1
  % Old-style mid point of 3 point filter - convert into actual filter
  r = -1/(r+2)*[1 r 1];
end

firlen = length(r);
firHlen = floor(firlen/2);

% Make right-going rail long enough to hold [r] points centered 
% at the end point (for calculating zero-phase reflection)
rlen = L + firlen - firHlen;
stringRight = zeros(1,rlen);

stringLeft = zeros(1,L);

% Does x specify pluck point?
if length(x) == 1
  % Interpret as proportion along string at which it is plucked
  pluck = x*(L-1);
  x = [ [0:floor(pluck)]/pluck, ...
	(L - 1 - [(floor(pluck)+1):(L-1)])/(L - 1 - pluck) ];
end

% Initialization
if length(x) < L
  dl = L - length(x);
  x = [zeros(1,floor(dl/2)), x, zeros(1,ceil(dl/2))];
end

% Because initial velocity profile is flat, initial displacement 
% profile is equal in leftgoing and rightgoing waves.
stringLeft(1:L) = x(1:L)/2;
stringRight(1:L) = x(1:L)/2;
% fill in extra point for bridge filter
stringRight(L+1) = 0;

% Initialize output
y = zeros(1,S);

% Initialize variables for display
pkval = max(abs(x));
ii = 0:(L-1);

%% Execute waveguide
for t = 1:S*mult
  
  if viz
    % Plot left and right-moving waves, and their sum
    plot(ii, stringLeft, ii, stringRight(1+ii), ii, stringLeft+stringRight(1+ii));
    % Make sure the axis scaling stays the same for each plot
    axis([0 L-1 -pkval pkval]);
    pause
  end
  
  % Apply forcing function:
  stringLeft(forceLoc) = stringLeft(forceLoc) + f(t);
  stringRight(forceLoc) = stringRight(forceLoc) + f(t);
  
  % Clamp the string appropriately:
  left = stringLeft(c(t):end);
  right = stringRight(c(t):end);
  % step waveguide:
  [left, right] = stepWaveguide(left, right, r);
  % put back on string:
  stringLeft = [zeros(1,c(t)-1), left];
  stringRight = [zeros(1,c(t)-1), right];
%[stringLeft, stringRight] = stepWaveguide(stringLeft, stringRight, r);

  % Read output
  if mod(t,mult) == 0
    y(t/mult) = stringLeft(pickup) + stringRight(pickup);
  end

end