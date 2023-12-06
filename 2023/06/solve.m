clc
lines = {};

fileID = fopen('input.txt','r');;
time_line = fgetl(fileID);
dist_line = fgetl(fileID);
fclose(fileID);

time_line = regexprep(time_line, '\D+: +', '');
dist_line = regexprep(dist_line, '\D+: +', '');
time_arr = regexp(time_line, ' +', 'split');
dist_arr = regexp(dist_line, ' +', 'split');
time_M = str2double(time_arr);
dist_M = str2double(dist_arr);

prod = 1;

% calc distance from time and max time
calc = @(t, max_time) t * (max_time-t);

for i = 1:length(time_M)
	max_time = time_M(i);
	max_dist = dist_M(i);
	sum = 0;
	for i = 1:(max_time-1)
		dist = calc(i, max_time);
		if dist > max_dist
			sum = sum + 1;
		end
	end
	prod = prod * sum;
end

fprintf('1st task product: %.0f\n', prod);

% remove kerning, make the array of number strings actually just one large number
max_time = str2double(strjoin(time_arr, ""));
max_dist = str2double(strjoin(dist_arr, ""));
% fprintf('max_time: %.0f\t\tmax_dist: %.0f\n', max_time, max_dist);

% indices when the win region begins and ends
t_start = 0;
t_end = max_time;
while calc(t_start, max_time) <= max_dist;
	t_start = t_start + 1;
end
while calc(t_end, max_time) <= max_dist;
	t_end = t_end - 1;
end

n = t_end-t_start + 1;
fprintf('2st task number of ways to win: %.0f\n', n);
