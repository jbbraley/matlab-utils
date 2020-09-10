function res = getMetaFromFileNames(root,expression)
%% so meta
%
% inputs:
%   root - base path to data files
%   expression - regular expression for pairing input location and average
%       number. this input is optional, see below
%
% output:
%   returns an array of structures,res, consisting of the following fields,
%   returned in ascending order of impact loation:
%   res(ii).
%       fileid - input location number (inLoc_avg.txt)
%       avg - average number
%       name - full pathname to file (root folder is prepended)
%
% * default expression is good for files containing two trailing
%       underscores like the following format:
%       -> 'yadda_yadda_yadda_inputNumber_averageNumber.txt'
%
% * the default expression will pull out inputNumber and average Number and
%       return a struct array consistent with the filenames in folder, root
%
%
% jdv 01032015; 10072016

if iscell(root); root = char(root); end

pth = dir(root); % get struct of directory names

% search for valid file name
% tokens
    if nargin < 2 || isempty(expression)
        % default -> 'md_crio2_1_3.txt'
        % res{1}.crio = '2'
        % res{1}.inloc = '1'
        % res{1}.avg = '3'
        % expression = '(?<daq>\d+)_(?<inloc>\d+)_(?<avg>\d+)';

        % NEW DEFAULT -> 'yada_yadda_yadda_trailer_1_3.txt'
        % res{1}.fileid = '1';
        % res{1}.avg = '3';
        expression = '_(?<fileid>\d+)_(?<avg>\d+)';
    end

    % match strings
    res = regexpi({pth.name},expression,'names');

    % index found entries
    chk = cellfun(@isempty,res);
    res = res(~chk); % not empty meta
    pth = pth(~chk); % not empty paths, consistent w/ meta


    if sum(not(chk)) == 0 % no pairs
        warning('did not find any matches. check path supplied');
    else
        % convert strings to nums, and add path to each matching result
        % structure
        for ii = 1:length(res)
%             res{ii}.fileid = str2num(res{ii}.fileid);
%             res{ii}.avg = str2num(res{ii}.avg);
            res{ii}.name = fullfile(root,pth(ii).name);
        end

%         % sort all entries in ascending impact location order
%         for ii = 1:length(res)
%             aa(ii) = res{ii}.fileid;
%         end
%         [Y,I] = sort(aa);
%         res = res(I);

        % convert cell array to struct array
        res = [res{:}];
    end
end
