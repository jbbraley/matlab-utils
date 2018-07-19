function [beta, R, Error] = fit(self)
%% fit
% fits model to training data 
% 
% 
% author: John Braley
% create date: 2018-06-26 02:27:30.292


if isempty(self.c_start)
    self.c_start = ones(1,self.num_c);
end

[beta R J CovB MSE Error] = nlinfit(self.X,self.y, self.fun, self.c_start);

% % create anonymous function that generates the data (residuals) to minimize
% 
% obj = @(coeff) rssq(self.fun(self.X,coeff)-self.y);
% 
% algOpt = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
%                 'TolFun',1e-6,...
%                 'TolX',1e-4,...
%                 'Display','iter');
% 

%             
% [x,resnorm,residual,exitflag,output] = lsqnonlin(obj,self.c_start,self.lb,self.ub,algOpt);
	
	
	
end
