% include fakta global
:- include('globalFact.pl').
% jeff
help :- \+ playerState(_), !, write('game belom dimulai').

help :- playerState('startGame'), !, write('udah startGame,belom di start').

help :- playerState('start'), !, write('bisa jalan, cek map, explore').

help :- playerState('house'), !, write('di dalam house').

help :- playerState('market'), !, write('di dalam market').