clc
M = []; % matrix of numbers from input [[opponent, me]; ...] where 1 = rock, 2 = paper, 3 = scissors


% FIRST INTERPRET THE GUIDE
% opponent: A = rock, B = paper, C = scissors
% myself:   X = rock, Y = paper, Z = scissors
legend = struct('A', 1, 'B', 2, 'C', 3, 'X', 1, 'Y', 2, 'Z', 3);
parse = @(char) getfield(legend,char);

fileID = fopen('input.txt','r');
tline = fgetl(fileID);
while ischar(tline)
    M = [M; [parse(tline(1)), parse(tline(3))]];
    tline = fgetl(fileID);
end
fclose(fileID);


% NOW CALCULATE POINTS
% points for selection of my sign
p_choice  = sum(M(:, 2));

% points for outcome
m1=M(:,1);
m2=M(:,2);
dm = m2 - m1;
draws = m1 == m2;
wins = dm > 0 & dm ~= 2 | dm == -2;
loss = dm < 0 & dm ~= -2 | dm == 2;
p_outcome = sum(draws)*3 + sum(wins)*6;
p_total = p_choice + p_outcome;

fprintf('total score: %.0f\n', p_total);
