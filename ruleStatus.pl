% File ruleStatus.pl
% Contributor : 13520042

% Include global facts
:- include('globalFact.pl').

% Facts for debugging purposes
%currentTime('12.00').
%currentDay('Thursday').
%level(5).
%class('Farmer').
%levelFarming(12).
%levelFishing(8).
%levelRanching(10).
%expFarming(6628).
%expFishing(3877).
%expRanching(4652).
%gold(12000).
%exp(13864).

status :-
    % Get latest data facts from global facts
    currentTime(Time),
    currentDay(Day),
    gold(Gold),
    class(Class),
    level(Level),
    exp(Exp),
    levelFarming(LevelFarming),
    expFarming(ExpFarming),
    levelFishing(LevelFishing),
    expFishing(ExpFishing),
    levelRanching(LevelRanching),
    expRanching(ExpRanching),

    % Displays facts on screen
    write('Day: '), write(Day), nl,
    write('Time: '), write(Time), nl, nl,
    write('Your status:'), nl,
    write('Gold: '), write(Gold), nl,
    write('Job: '), write(Class), nl,
    write('Level: '), write(Level), nl,
    write('Experience: '), write(Exp), nl,
    write('Farming Level: '), write(LevelFarming), nl,
    write('Farming Exp: '), write(ExpFarming), nl,
    write('Fishing Level: '), write(LevelFishing), nl,
    write('Fishing Exp: '), write(ExpFishing), nl,
    write('Ranching Level: '), write(LevelRanching), nl,
    write('Ranching Exp: '), write(ExpRanching), nl.
