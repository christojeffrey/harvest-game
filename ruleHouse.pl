% jeff
:- include('globalFact.pl').

% fact
% rule

house :-
    retract(playerState(_)),
    assertz(playerState('house')),
    write('welcome home!'),
    write('what do you want to do?\n'),
    write('- sleep\n'),
    write('- writeDiary\n'),
    write('- readDiary\n'),
    write('- exitHouse\n').


sleep :-
    playerState('house'),!,
    write('sleeping...\n'), 
    sleep(1),
    write('it\'s a new day!\n'),
    currentDay(CD),
    CDnew is CD + 1,
    retract(currentDay(CD)),
    assertz(currentDay(CDnew)),
    write('day '),write(CDnew),write('\n'),
    write('exit the house, explore, and soon you will be able to pay your debt!\n').

sleep :-
    write('kamu sedang tidak di rumah. pulang dulu baru bisa bobok\n').


exitHouse :-
    playerState('house'),!,
    write('exiting house').
exitHouse :- 
    write('kamu tidka sedang di rumah.\n').
