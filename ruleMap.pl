% digunakan untuk menampilkan map, dan untuk berpindah.

% include fakta global
% :- include('globalFact.pl').
% :- include('globalRule.pl').
%map :- write('ini map').


isBorderAtas(_,H):- H=:=0,!.
isBorderBawah(_,H):- Y is H-1, tinggiMap(Y),!.
isBorderKiri(L,_):- L=:=0,!.
isBorderKanan(L,_):- X is L-1, lebarMap(X),!.



printCoord(X,Y):-
    playerLoc(X1,Y1),
    (X==X1),(Y==Y1),!,
    write('P').

printCoord(X,Y):-
    isBorderAtas(X,Y),!,
    write('#').

printCoord(X,Y):-
    isBorderBawah(X,Y),!,
    write('#').

printCoord(X,Y):-
    isBorderKanan(X,Y),!,
    write('#').

printCoord(X,Y):-
    isBorderKiri(X,Y),!,
    write('#').

printCoord(X,Y):-
    waterLoc(X,Y),!,
    write('o').

printCoord(X,Y):-
    ranchLoc(X,Y),!,
    write('R').

printCoord(X,Y):-
    marketPlaceLoc(X,Y),!,
    write('M').

printCoord(X,Y):-
    houseLoc(X,Y),!,
    write('H').

printCoord(X,Y):-
    questLoc(X,Y),!,
    write('Q').

printCoord(X,Y):-
    diggedLoc(X,Y),!,
    write('=').
printCoord(X,Y) :-
    plantedLoc(X,Y,Name,_,_),!,
    (
        (
            Name = 'corn',write('c')
        );(
            Name = 'carrot',write('r')
        );(
            Name = 'wheat',write('w')
        )
    ).

printCoord(_,_):-
    write('-').


printLegend :-
    write('w======| + |=======  w  ======| + |=======w'),nl,
    write('      Legends:'),nl,
    write('       M     : Marketplace'),nl,
    write('       R     : Ranch'),nl,
    write('       H     : House'),nl,
    write('       Q     : Tempat pengambilan quest'),nl,
    write('       o     : Tile air'),nl,
    write('       =     : Digged tile'),nl,
    write('w======| + |=======  w  ======| + |=======w'),nl.

printMap:-
    tinggiMap(T),
    lebarMap(L),
    X is 0,
    Y is 0,
    Xmax is L+1,
    Ymax is T+1,
    write('w======| + |======= w ======| + |=======w'),nl,
    write('|       This your Map Captain!!!        |'),nl,
    write('w======| + |======= w ======| + |=======w'),nl,
    forall(between(Y, Ymax, I),(
        forall(between(X,Xmax,J),(
            printCoord(J,I)
        )),
        nl
    )),
    !.

map:-
    playerState('start'),!,
    printMap,
    printLegend.
map :-
    write('kamu tidak bisa melihat map saat sedang melakukan explorasi atau belum memulai game\n').

d:-
    playerState('start'),
    playerLoc(X,Y),
    X1 is X + 1,
    isBorderKanan(X1,Y),
    write('Mentok gaiss..'),!.

d:-
    playerState('start'),
    playerLoc(X,Y),
    X1 is X +1,
    waterLoc(X1,Y),
    write('Ati-ati nyebur..'),!.

d:-
    playerState('start'),
    playerLoc(X,Y),
    X1 is X+1,
    retractall(playerLoc(X,Y)),
    assertz(playerLoc(X1,Y)),
    write('Berhasil melangkah ke kanan 1 tile'),nl,!.
d :-
    write('kamu tidak bisa berpindah saat sedang eksplorasi\n').
w:-
    playerState('start'),
    playerLoc(X,Y),
    Y1 is Y-1,
    isBorderAtas(X,Y1),
    write('Mentok gaiss..'),!.
w:-
    playerState('start'),
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    write('Ati-ati nyebur..,'),!.

w:-
    playerState('start'),
    playerLoc(X,Y),
    Y1 is Y-1,
    retractall(playerLoc(X,Y)),
    asserta(playerLoc(X,Y1)),
    write('Berhasil melangkah ke atas 1 tile'),nl,!.
w :-
    write('kamu tidak bisa berpindah saat sedang eksplorasi\n').
s:-
    playerState('start'), 
    playerLoc(X,Y),
    Y1 is Y+1,
    isBorderBawah(X,Y1),
    write('Mentok gaiss..'),!.
s:-
    playerState('start'),
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    write('Ati-ati nyebur..'),!.

s:-
    playerState('start'),
    playerLoc(X,Y),
    Y1 is Y+1,
    retractall(playerLoc(X,Y)),
    asserta(playerLoc(X,Y1)),
    write('Berhasil melangkah ke bawah 1 tile'),nl,!.

s :-
    write('kamu tidak bisa berpindah saat sedang eksplorasi\n').
a:-
    playerState('start'),
    playerLoc(X,Y),
    X1 is X -1,
    isBorderKiri(X1,Y),
    write('Mentok gaiss..'),!.

a:-
    playerState('start'),
    playerLoc(X,Y),
    X1 is X -1,
    waterLoc(X1,Y),
    write('Ati-ati nyebur..'),!.
a:-
    playerState('start'),
    playerLoc(X,Y),
    X1 is X-1,
    retractall(playerLoc(X,Y)),
    asserta(playerLoc(X1,Y)),
    write('Berhasil melangkah ke kiri 1 tile'),nl,!.
a :-
    write('kamu tidak bisa berpindah saat sedang eksplorasi\n').