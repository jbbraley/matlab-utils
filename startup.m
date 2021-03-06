function startup
%% default matlab start up routine
    fprintf('Hello, John. Its nice to see you again. \n');
    fprintf('Ill go ahead and initialize some things for you.\n');


    %% shuffle random numbers
    fprintf('Shuffling random numbers... ');
    rng('shuffle');
    fprintf('Done.\n');
    
    %% add desired folders to matlab search path
    
    root = 'C:\Users\John B\Projects_Git'; % paths to add
    
    % folders to add
    folders = { 'matlab-utils', ...
				'BEAST\data\code'};

    fprintf('\tAdding paths:\n');
    for ii = 1:length(folders)
        fname = fullfile(root,folders{ii});
        addpath(genpath(fname));
        fprintf('\t\t%s\n',fname);
    end
    fprintf('\tDone. Enjoy\n');
    
	%% change working directory to root
	cd(root);
    
    %% set default fonts
    set(0,'defaultAxesFontName', 'Calibri>');
end