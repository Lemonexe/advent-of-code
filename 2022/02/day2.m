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

% FIRST PART, see calculate_total_points
fprintf('PART 1 total score: %.0f\n', calculate_total_points(M));

% SECOND PART, see refine_M
% actually, M is not M, because X = need to lose, Y = need to draw, Z = need to win
fprintf('PART 2 total score: %.0f\n', calculate_total_points(refine_M(M)));

% Calculate total points from the matrix M
function p_total = calculate_total_points(M)
    m1=M(:,1);
    m2=M(:,2);

    % points for selection of my sign
    p_choice  = sum(m2);

    % points for outcome
    dm = m2 - m1;
    draws = m1 == m2;
    wins = dm > 0 & dm ~= 2 | dm == -2;
    loss = dm < 0 & dm ~= -2 | dm == 2;
    p_outcome = sum(draws)*3 + sum(wins)*6;
    
    p_total = p_choice + p_outcome;
end

% As per updated instructions from the elf, correct what was thought to be M, to the actual M
function new_M = refine_M(M)
    m1=M(:,1);
    m2=M(:,2);
    draws_turns = m1 .* (m2==2); % my sign when it is suppossed to be draw

    loss_turns = (10+m1-1) .* (m2==1);
    loss_turns = (loss_turns > 10) .* (loss_turns - 10) + (loss_turns == 10) * 3;
    win_turns = (10+m1+1) .* (m2==3);
    win_turns = ((win_turns > 10) & (win_turns < 14)) .* (win_turns - 10) + (win_turns == 14) * 1;

    new_m2 = loss_turns + draws_turns + win_turns;
    new_M = [m1, new_m2];
end

%{
    DEBUG
    M = [1 1; 1 2; 1 3; 2 1; 2 2; 2 3; 3 1; 3 2; 3 3]
%}
