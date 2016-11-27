function example(N)
clc
% Number of iterations (in seconds).
if nargin<1; N = 50; end
fprintf('Message Log Example:\n\n\n');

% Create instance of Timerwaitbar.
logg = msglog.progressbar(N,'Logged Loop Example');

% Do work.
for n = 1:N
%     logg.start(sprintf('task %i',n))
    
    % Work.
    pause(.1);   

    % Update UI with status message. 
    logg.update(n);
    
end
logg.finish()