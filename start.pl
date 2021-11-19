:- include('globalFact.pl').

start :- write('welcome to hell'), assertz(level(0)).

% contoh perintah
addLevel :- write('menambah level...'), 
            retract(level(PrevLevel)),
            NewLevel is PrevLevel + 1, 
            assertz(level(NewLevel)).