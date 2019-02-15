function thesis_dbl(self)
%% thesis_dbl
% 
% 
% 
% author: John Braley
% create date: 2018-10-10 02:19:06.746
	
self.width = 800;
self.height = 300;
% self.color_scheme 

if isempty(self.ah)
    self.fh = figure('Position',[100 50 self.width self.height]);
    self.ah(1) = subplot(1,2,1);	
    self.ah(2) = subplot(1,2,2);
else
    self.fh.Position = [100 50 self.width self.height];
end

for ii = 1:length(self.ah)
    self.ah(ii).XLabel.FontSize = 11;
    self.ah(ii).YLabel.FontSize = 11;
    self.ah(ii).Title.FontSize = 11;
end
