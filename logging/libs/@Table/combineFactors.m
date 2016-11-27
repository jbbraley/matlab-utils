function res = combineFactors(this, varargin)
%COMBINEFACTORS Aggregate two factors to create a new factor
%
%   RES = combineFactors(GROUP)
%   Extract group indices and names from the input GROUP. The input GROUP
%   can be either:
%   * a cell array of values
%   * a numeric array
%   * a data table (assuming factor columns)
%   The output variable RES is a new data table, containing for each row
%   the result of the combination of the different factors.
%
%   Example
%     % create a table with two different group values
%     TAB = Table([1 1; 1 2; 1 1; 1 2; 2 3; 2 4; 2 3], {'group1', 'group2'});
%     TAB.setAsFactor([1 2]);
%     % combien the two factor columns
%     RES = combineFactors(TAB, 1:2)
%         RES = 
%                  group1*group2
%         1                  1*1
%         2                  1*2
%         3                  1*1
%         4                  1*2
%         5                  2*3
%         6                  2*4
%         7                  2*3
%     % show the unique levels of the resulting factor
%     RES.levels{1}
%         ans = 
%             '1*1'
%             '1*2'
%             '2*3'
%             '2*4'
%
%   See also
%     reorderLevels

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-04-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.


%% Parse input arguments

keepFactorNames = false;

% parse input options
while length(varargin) > 1
    paramName = lower(varargin{1});
    switch paramName
        case 'keepfactornames'
            keepFactorNames = varargin{2};
        otherwise
            error(['Unknown parameter name: ' paramName]);
    end

    varargin(1:2) = [];
end


%% Compute new groups as combination of input groups

[nameIndices, pos, groupIndices] = unique(this.data, 'rows'); %#ok<ASGLU>

levelNames = cell(size(nameIndices));
for iGroup = 1:size(levelNames, 2)
    if isFactor(this, iGroup)
        % in case of factor, extract stored levels
        levelInds = unique(nameIndices(:,iGroup));
        levels = this.levels{iGroup};
        if length(levelInds) > length(levels)
            error('Not enough level names for factor data');
        end
        
    else
        % in case of numeric variable, create cell array from numeric
        % levels, and update name indices
        [levelInds, pos, inds] = unique(nameIndices(:,iGroup)); %#ok<ASGLU>
        
        nameIndices(:,iGroup) = inds;
        levels = strtrim(cellstr(num2str(levelInds)));
    end
    
    % associate each level index to level name
    for iLevel = 1:length(levelInds)
        % index of current level
        index = levelInds(iLevel);
        
        % find indices
        inds = nameIndices(:,iGroup) == index;
        
        % associate name to index
        levelNames(inds, iGroup) = levels(index);
    end
    
end



%% Compute the names of the nes levels

labels = levelNames;

if keepFactorNames
    format = '%s=%s';
    % iterate on the different factors
    for iGroup = 1:size(levelNames, 2)
        groupLabel = this.colNames{iGroup};

        for iLevel = 1:size(levelNames, 1)
            levelName = levelNames{iLevel, iGroup};
            if isnumeric(levelName)
                levelName = num2str(levelName);
            end
            label = sprintf(format, groupLabel, levelName);
            labels{iLevel, iGroup} = label;
        end
    end
end

% Concatenate the different level names to create new level names
if keepFactorNames
    levelNamesSep = ';';
else
    levelNamesSep = '*';
end
if size(labels, 1) > 1
    tmp = labels;
    labels = labels(:, 1);
    for iCol = 2:size(tmp, 2)
        labels = strcat(labels, levelNamesSep, tmp(:,iCol));
    end
end


%% Create resulting data table

colNames = {[this.colNames{1} '*' this.colNames{2}]};

res = Table(groupIndices, ...
    'colNames', colNames, ...
    'rowNames', this.rowNames, ...
    'levels', {labels});
