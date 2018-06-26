function newobj = fill_empty_class(self, newobj)
%% fillempty
% 
% fills empty fields in var1 with values from corresponding fields in var2
% 
% author: John Braley; John DeVitis
% create date: 08-Sep-2016 16:11:14
    class_meta1 = metaclass(self);
    class_meta2 = metaclass(newobj);
    numfields = length(class_meta1.PropertyList);
    for ii = 1:numfields        
        fieldname = class_meta1.PropertyList(ii).Name;
        ind = strcmp(fieldname, {class_meta2.PropertyList.Name});
        if isprop(newobj,fieldname) && isempty(newobj.(fieldname)) && ~class_meta2.PropertyList(ind).Dependent
            newobj.(fieldname) = self.(fieldname);
        end
    end	
end
