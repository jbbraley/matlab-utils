function [count] = CountTrigger(dat, trig_val)
%% CountTrigger
% Counts the number of times data exceeds a threshold value
% 
% 
% author: John Braley
% create date: 23-Aug-2016 12:07:37

% Find all values greater than trigger value
exceed = dat>trig_val;	
% Locate all transitions from one side of trigger to other
trans = exceed(2:end,:)-exceed(1:end-1,:);
% Count transitions
count = sum(abs(trans),1)/2;
	
end
