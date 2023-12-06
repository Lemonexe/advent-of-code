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

for i = 1:length(time_M)
	max_time = time_M(i);
	max_dist = dist_M(i);
	sum = 0;
	for i = 1:(max_time-1)
		dist = i * (max_time-i);
		if dist > max_dist
			sum = sum + 1;
		end
	end
	prod = prod * sum;
end

fprintf('1st task product: %.0f\n', prod);

