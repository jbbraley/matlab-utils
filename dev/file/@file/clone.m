function new = clone(self)
%% clone
% 
% 
% 
% author: John Braley
% create date: 2018-09-05 01:04:55.626
	

% make a clone of instance
new = feval(class(self));

p = properties(self);
info = metaclass(self);

for ii = 1:length(p)
    if ~info.PropertyList(ii).Dependent
        new.(p{ii}) = self.(p{ii});
    end
end
        	
end
