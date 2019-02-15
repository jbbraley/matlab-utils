function thesis_single(self)
%% thesis_single
% 
% 
% 
% author: John Braley
% create date: 2018-10-10 02:19:06.746
	
self.width = 500;
self.height = 250;
% self.color_scheme 

if isempty(self.ah)
    self.fh = figure('Position',[100 50 self.width self.height]);
    self.ah = axes;	
else
    self.fh.Position = [100 50 self.width self.height];
end

self.ah.XLabel.FontSize = 11;
self.ah.YLabel.FontSize = 11;
self.ah.Title.FontSize = 11;
end
