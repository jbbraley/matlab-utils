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

%% use for simple (arithmetic) function
% [beta R J CovB MSE Error] = nlinfit(self.X,self.y, self.fun, self.c_start);

%% use for complex functions
% create anonymous function that generates the data (residuals) to minimize
if isempty(self.X)
    obj = @(coeff) (self.fun(coeff)-self.y);
else
    obj = @(coeff) (self.fun(self.X,coeff)-self.y);
end
% rss = @(coeff) rssq(obj(coeff)) for use with minimization algorithms that
% dont compute root-sum-of squares

algOpt = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
                'TolFun',1e-6,...
                'TolX',1e-4,...
                'Display','iter');
            
[beta,resnorm,R,Error,output] = lsqnonlin(obj,self.c_start,self.lb,self.ub,algOpt);
	
	
	
end
