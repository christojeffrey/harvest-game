% digunakan untuk menampilkan status

% include fakta global
:- include('globalFact.pl').

% Facts for debugging purposes
% level(5).
% class('Farmer').
% levelFarming(12).
% levelFishing(8).
% levelRanching(10).
% expFarming(6628).
% expFishing(3877).
% expRanching(4652).
% gold(12000).
% exp(13864).

% Getting facts' value
gold(Gold).
class(Class).
level(Level).
exp(Exp).
levelFarming(LevelFarming).
expFarming(ExpFarming).
levelFishing(LevelFishing).
expFishing(ExpFishing).
levelRanching(LevelRanching).
expRanching(ExpRanching).

status :- 
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