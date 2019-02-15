classdef plotter < handle
%% classdef plotter
% 
% 
% 
% author: John Braley
% create date: 2018-10-10 02:10:37.283
% classy version: 0.1.2

%% object properties
	properties
        fh      % figure handle
        ah      % axis handle
        width   % width of figure
        height  % height of figure
        color_scheme
        xlabel
        ylabel
        legend
        title
        style
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% constructor
	methods
		function self = plotter(argin)
            if ischar(argin) % new plot with specified style function
                self.style = argin;
                self.(argin);
            elseif strcmp(get(argin,'type'),'axes') % construct with existing axes handle
                self.ah = argin;
                self.fh = ancestor(argin,'figure');
            elseif strcmp(get(argin,'type'),'figure') % construct with existing figure handle
                self.fh = argin;
                self.ah = get(argin,'Children');
            end
		end
	end

%% ordinary methods
	methods 
        function plot(self,xdat,ydat)
            plot(self.ah,xdat,ydat);
            self.refresh                    
        end
        
        function copy(self)
           hgexport(self.fh,'-clipboard') 
        end
        
	end % /ordinary

%% dependent methods
	methods 
        function set.style(self,name)
            self.style = name;
            self.(name);
        end
	end % /dependent

%% static methods
	methods (Static)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end
