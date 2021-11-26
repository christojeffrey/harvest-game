% rule house.
% dimulai dari rule 'house.'. untuk bisa elkaukan hal tersebut, playerState harus start.
% untuk bisa menjalankan command turunan house, playerState harus 'house.'

% fact
:- dynamic(diary/2).

% rule
house :-
    % playerLoc(Baris, Kolom), houseLoc(Baris,Kolom),!,
    retract(playerState(_)),
    assertz(playerState('house')),
    write('welcome home!\n'),
    currentDay(DayNow),
    write('it\'s day '), write(DayNow),nl,
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
    retract(currentDay(CD)),
    assertz(currentDay(CDnew)),
    retract(currentTime(_)),
    assertz(currentTime(7)),
    failState,
    write('day '),write(CDnew),write('\n'),
    write('masih pukul 7 pagi, exit the house, explore, and soon you will be able to pay your debt!\n').

sleep :-
    write('kamu sedang tidak di rumah. pulang dulu baru bisa bobok\n').

% game akan berakhir ketika day 5 sudah berakhir.
failState :-
    currentDay(CD),
    (CD > 5,!,
    write('waktumu sudah habis, game berakhir.\n'),
    retractAll, fail; write('kamu masih punya waktu untuk mencari uang\n')).


% tambahkan retract semuanya
retractAll :-
    retract(playerState(_)).



writeDiary:-
    currentDay(CD),
    \+ diary(CD,_),!,
    playerState('house'),!,
    write('dear diary,(tulis menggunakan petik dua diawal dan diakhir sebelum titik)\n>'),
    read(X), atom_codes(DiaryText,X),
    write('diary text'),nl,
    write(DiaryText),
    assertz(diary(CD, DiaryText)).

writeDiary:-
    write('kamu tidak bisa menulis diary. kamu sedang tidak dirumah atau kamu sudah meulis diary hari ini.\n').


% belom ngecover kalo diary lebih dari satu
readDiary:-
    playerState('house'),!,
    write('read diary'),nl,
    printAllDayWithDiary,
    write('pilih diary yang mau dibaca(masukkan angka 1, 2, dst)\n>'),
    read(DayChoosen), nl,
    write('diary day '), write(DayChoosen),write(': '),
    diary(DayChoosen,TextChoosen),
    write(TextChoosen),nl.

readDiary:-
    write('kamu tidak sedang di rumah.\n').

printAllDayWithDiary:-
    forall(diary(Day,_),(write(' - day '), write(Day),nl)).
    % diary(Day,_),
    % write(' - day '), write(Day),nl.


exitHouse :-
    playerState('house'),!,
    write('exiting house'),
    retract(playerState(_)),
    assertz(playerState('start')).
exitHouse :- 
    write('kamu tidak sedang di rumah.\n').
