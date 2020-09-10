function make508(self)
%% make508
% 
% Currently works for line type plots only
% Goes through all series and changes the line type and color to be 508
% compliant
% author: 
% create date: 01-Jul-2020 17:04:09
% formatting array
colors = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980];  [0.4660 0.6740 0.1880]]; 
colors = colors(end:-1:1,:);
markers = {'none'; 'none'; '.'};
linetypes = {'-.';'--';'-'};
linewidth = [1 1 1];

% get handle of line objects

lines = get(self.ah,'Children');
n=0;
for ii = 2:length(lines)
    n=n+1;
    lines(ii).Color = colors(n,:);
    lines(ii).Marker = markers{n};
    lines(ii).LineStyle = linetypes{n};
    lines(ii).LineWidth = linewidth(n);
end	


	
end
