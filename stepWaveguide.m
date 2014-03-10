function [left, right] = stepWaveguide( left, right, clamp, r )
% [left, right] = stepWaveguide( left, right, clamp )
% Propagates waveguide forward one step.

firlen = length(r);
firHlen = floor(firlen/2);

len = clamp;
% Move left-hand moving wave one step left; append dummy value for now
left = [left(2:len),0];
% At 'nut' (left-hand end), assume perfect reflection, so new value 
% of right-moving wave is negative of new value at nut of left-moving
nut = -left(1);
% Move right-moving wave one step (including extra point off end)
right = [nut, right(1:len)];
% Apply 'bridge' filter to end points of right-moving wave to get 
% new value to fill in to end of left-moving wave
% One point of convolution
bridge = r * right( (len-firHlen-1)+[1:firlen] )';
left(len) = bridge;  

end