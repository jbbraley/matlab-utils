function refresh(self)
%% refresh
% 
% 
% 
% author: John Braley
% create date: 2018-10-10 03:22:15.297
            
self.ah.XLabel.String = self.xlabel; 
self.ah.YLabel.String = self.ylabel; 
self.ah.Title.String = self.title; 
if ~isempty(self.legend)
   legend(self.ah,self.legend);
end

% size
self.fh.Position = [100 50 self.width self.height];
	
	
	
	
end
