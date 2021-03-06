classdef logger < handle
%% Message Logger Class
%
% Example:
%   N = 10;
%   logg = logger('Logged Loop Example');
%   for n=1:N
%       logg.task('Loop iteration',n,N)
%       % do work
%       logg.done()
%   end
%   logg.stop;
%
% author: john devitis
% create date: 26-Nov-2016 13:54:58
% classy ver: 0.1.1

%% object properties
	properties
        prefix = 'LOG'              % lin write prefix
        process = 'Main'            % process name
        fid = 1                     % write location -> default to console
        born                        % datetime string of log creation
        process_born                % process born date time string
        delim = '\t'                % line delimiter
        header_order = [1 2 3]      % log name, time, process, task
        prefixf = '%s:'             % prefix format string
        timef = '%s'          % time format string
        processf = 'Process(%s):'   % process format string
        taskf = 'Task(%s):'         % task format string
		current_task
    end

%% dependent properties
    properties (Dependent)
        header
		alive_time
		task_time
    end

%% constructor
	methods
		function self = logger(process,filename)
            % record create time and publish start
            self.born = datestr(datetime);
            % save process name if given
            if nargin > 0 && ischar(process); self.process = process; end;
            % open file in append mode if given
            if nargin > 1; self.fid = fopen(filename,'a'); end
            % finally, start the process if name given
            if nargin > 0; self.start(); end;
		end
	end

%% ordinary methods
	methods
		function resetclock(self)
			self.process_born = datestr(datetime);
		end

        function print_header(self)
        %% print sorted header
            fprintf(self.fid,strcat(self.header,self.delim));
        end

        function print(self,txt,hd,nl)
        %% print logged message
        %  optional: hd=1 for header. nl=1 for new line.
            if nargin < 3; hd = 1; end;
            if nargin < 4; nl = 1; end;
            if hd; self.print_header(); end;
            if nl; ftxt = '%s\n';
            else ftxt = '%s'; end
            fprintf(self.fid,sprintf(ftxt,txt));
        end

		function printalive(self)
			%% print process alive time
			%tot = etime(clock,datevec(self.process_born));
			%alive_string = sprintf('Alive for %4.2f seconds (%4.2f minutes).',tot,tot/60);
			self.print(self.alive_time);
		end

        function start(self,name,msg)
        %% start logging main process
            if nargin > 1 && ischar(name); self.process = name; end;
            if nargin < 3; msg = ''; end
            self.process_born = datestr(datetime);
            self.print(sprintf('Started. %s',msg));
        end

        function stop(self)
        %% log process completion and shutdown.
        %  note - shutdown is wrapped here so we know that was completed
        %  successfully.
			self.print([self.process ' done. ' self.alive_time]);
			self.process = '';
        end

        function shutdown(self)
        %% over-writable method for deterministic shutdown

        end

        function task(self,name,n,N)
        %% start named task.
            ftxt = strjoin({self.taskf,''},self.delim);
            % default task name if none given
            if nargin < 2; name = 'Loop Iteration'; end;
            % if no loop numbers given, just print name
            if nargin < 3; txt = sprintf(ftxt,name);
            % if loop numbers given, print n of N tasks
            else txt = sprintf(strcat(ftxt,'\t%i\tof\t%i\t...'),name,n,N); end
            self.print(txt,1,0);
        end

		function starttask(self,tsk)
			self.resetclock;
			self.current_task = tsk;
			self.print(['Started ' tsk]);
		end

		function done(self)
		%% log process
			if isempty(self.current_task)
				self.print(['Done. ' self.task_time]);
			else
				self.print([self.current_task ' done. ' self.task_time]);
				self.current_task = [];
			end
		end

		function finish(self)
			self.print(['Process finished. '], self.alive_time);
		end

		function alive_time = get.alive_time(self)
			tot = etime(clock,datevec(self.born));
			alive_time = sprintf('Alive for %4.2f seconds (%4.2f minutes).',tot,tot/60);
		end

		function task_time = get.task_time(self)
			tot = etime(clock,datevec(self.process_born));
			task_time = sprintf('Alive for %4.2f seconds (%4.2f minutes).',tot,tot/60);
		end


        function run(self,N)
        %% run through N logging events as demo process. helpful for
        % sorting out format string
            clc; fprintf('Logger demo-run:\n')
            if nargin < 2; N = 10; end;
            self.start('start demo-run')
            for n = 1:N
                self.task('demo-run',n,N);
                self.done()
            end
            self.stop()
        end

        function nl(self)
        %% go to new line. inserts return '\n' at cursor.
            fprintf(self.fid,'\n');
        end

	end % /ordinary

%% dependent methods
    methods
        function header = get.header(self)
        %% get header based on format strings
            strings = {self.prefixf, self.timef, self.processf};
            values = {self.prefix, datestr(datetime), self.process};
            fstring = strjoin(strings(self.header_order),self.delim);
            header = sprintf(fstring,values{self.header_order});
        end
    end % /dependent

%% static methods
	methods (Static)
        example
	end % /static

end
