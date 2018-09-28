classdef model < handle
%% classdef model
% 
% 
% 
% author: John Braley
% create date: 2018-06-26 02:21:35.847
% classy version: 0.1.2

%% object properties
	properties
        fun % handle for function (y=f{coeff, X} that predicts y based on  the predictors in X
        X % predictors for function
        y % results of function based on predictors in X
        coeff % coefficient in fun
        num_c % number of coefficents in fun
        lb % lower bound for coefficients
        ub % upper bound for coefficients
        c_start % starting values for coefficients
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% constructor
	methods
		function self = model()
		end
	end

%% ordinary methods
	methods 
	end % /ordinary

%% dependent methods
	methods 
	end % /dependent

%% static methods
	methods (Static)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end
