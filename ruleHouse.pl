% jeff
:- include('globalFact.pl').

% fact
:- dynamic(diary/2).

% temporary
set :- assertz(playerState('start')),
assertz(currentDay(1)).

% rule
house :-
    % playerLoc(Baris, Kolom), houseLoc(Baris,Kolom),!,
    retract(playerState(_)),
    assertz(playerState('house')),
    write('welcome home!'),
    write('what do you want to do?\n'),
    write('- sleep\n'),
    write('- writeDiary\n'),
    write('- readDiary\n'),
    write('- exitHouse\n').
% house:-
%     write('kamu sedang tidak di lokasi rumah. pergilah kesana terlebih dahulu.\n').

sleep :-
    playerState('house'),!,
    write('sleeping...\n'), 
    sleep(1),
    write('it\'s a new day!\n'),
    currentDay(CD),
    CDnew is CD + 1,
    % tambahi pengecekan hari baru, jika sudah > batas, maka game berakhir
    retract(currentDay(CD)),
    assertz(currentDay(CDnew)),
    write('day '),write(CDnew),write('\n'),
    write('exit the house, explore, and soon you will be able to pay your debt!\n').

sleep :-
    write('kamu sedang tidak di rumah. pulang dulu baru bisa bobok\n').




writeDiary:-
    currentDay(CD),
    \+ diary(CD,_),!,
    playerState('house'),!,
    write('dear diary,\n>'),
    read(X), atom_codes(DiaryText,X),
    write('diary text'),nl,
    write(DiaryText),
    assertz(diary(CD, DiaryText)).

writeDiary:-
    write('kamu tidak sedang di rumah atau kamu sudah menulis diary untuk hari ini.\n').


% belom ngecover kalo diary lebih dari satu
readDiary:-
    playerState('house'),!,
    write('read diary'),nl,
    diary(Day,Text),
    write(' - day '), write(Day),nl,
    read(DayChoosen), nl,
    write('diary day '), write(DayChoosen),write(': '),
    diary(DayChoosen,TextChoosen),
    write(TextChoosen),nl.

readDiary:-
    write('kamu tidak sedang di rumah.\n').



exitHouse :-
    playerState('house'),!,
    write('exiting house').
exitHouse :- 
    write('kamu tidak sedang di rumah.\n').
