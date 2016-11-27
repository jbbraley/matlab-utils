function res = lt(this, that)
%LT  Overload the lt operator for Table objects
%
%   output = lt(input)
%
%   Example
%   lt
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-02,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

[this, that, parent, names1, names2] = parseInputCouple(this, that, inputname(1), inputname(2));

% error checking
if hasFactors(parent)
    error('Can not compute lt for table with factors');
end

% compute new data
newData = bsxfun(@lt, this, that);

newColNames = strcat(names1, '<', names2);

% create result array
res = Table.create(newData, ...
    'parent', parent, ...
    'colNames', newColNames);
