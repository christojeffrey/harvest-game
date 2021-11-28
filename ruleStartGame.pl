% startGame.
% ->menampilkan menu. rule pertama yang diakses

% :- include('globalFact.pl').

startGame:-
    \+ playerState(_),!,
    assertz(playerState('startGame')),
    write('                     \''), nl,
    write('              .      \'      .'), nl,
    write('        .      .     :     .      .'), nl,
    write('         \'.        ______       .\''), nl,
    write('           \'  _.-"`      `"-._ \''), nl,
    write('            .\'                \'.   '), nl,
    write('     `\'--. /                    \\ .--\'`'), nl,
    write('          /                      \\'), nl,
    write('         ;                        ;'), nl,
    write('    - -- |                        | -- -'), nl,
    write('         |     _.                 |'), nl,
    write('         ;    /__`A   ,_          ; '), nl,
    write('     .-\'  \\   |= |;._.}{__       /  \'-.'), nl,
    write('        _.-""-|.\' # \'. `  `.-"{}<._'), nl,
    write('              / 2021  \\     \\  x   `"'), nl,
    write('         ----/         \\_.-\'|--X----'), nl,
    write('         -=_ |         |    |- X.  =_'), nl,
    write('        - __ |_________|_.-\'|_X-X##'), nl,
    write('        jgs `\'-._|_|;:;_.-\'` \'::.  `"-'), nl,
    write('         .:;.      .:.   ::.     \'::.'), nl,
    write('harvest iPhone 13\n'),
    write('collect money and pay your debt!\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('%                              ~Harvest iPhone 13~                             %'), nl,
    write('% 1. start       : untuk memulai petualanganmu                                 %'), nl,
    write('% 2. help        : menampilkan segala bantuan                                  %'), nl,
    write('% 3. exitGame    : Keluar dari pemainan                                        %'), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl.

startGame :-
    write('Game sudah dimulai\nUntuk keluar gunakan exitGame').
exitGame :-
    playerState(_),!, write('game berakhir. good bye!\n'), resetAllState,!.

exitGame :-
    write('kamu tidak sedang bermain\n').
