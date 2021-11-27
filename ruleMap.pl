% digunakan untuk menampilkan map, dan untuk berpindah.

% include fakta global
:- include('globalFact.pl').
:- include('globalRule.pl').
%map :- write('ini map').

%w :- %write('kamu bergerak ke arah utara sebanyak 1 tile').
%a :- %write('kamu bergerak ke arah barat sebanyak 1 tile').
%s :- %write('kamu bergerak ke arah selatan sebanyak 1 tile').
%d :- %write('kamu bergerak ke arah timur sebanyak 1 tile').


isBorderAtas(_,H):- H=:=0,!.
isBorderBawah(_,H):- Y is H, tinggiMap(Y),!.
isBorderKiri(L,_):- L=:=0,!.
isBorderKanan(L,_):- X is L, lebarMap(X),!.



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

printCoord(_,_):-
    write('-').


printLegend():-
    write('Legends:'),nl,
    write(' M	: Marketplace'),nl,
    write(' R	: Ranch'),nl,
    write(' H	: House'),nl,
    write(' Q	: Tempat pengambilan quest'),nl,
    write(' o	: Tile ai'),nl,
    write(' =	: Digged tile'),nl.

printMap:-
    tinggiMap(T),
    lebarMap(L),
    X is 0,
    Y is 0,
    Xmax is L,
    Ymax is T,
    forall(between(Y, Ymax, I),(
        forall(between(X,Xmax,J),(
            printCoord(J,I)
        )),
        nl
    )),
    !.

map:-
    printMap,
    printLegend.

d:-
    playerLoc(X,Y),
    X1 = X +1,
    isBorderKanan(X1,Y),
    write('Mentok gaiss..').

d:-
    playerLoc(X,Y),
    X1 = X +1,
    waterLoc(X1,Y),
    write('Ati-ati nyebur..').

d:-
    playerLoc(X,Y),
    X1 is X+1,
    retractall(playerLoc(X,Y)),
    assertz(playerLoc(X1,Y)),!.

w:-
    playerLoc(X,Y),
    Y1 is Y-1,
    isBorderAtas(X,Y1),
    write('Mentok gaiss..').
w:-
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    write('Ati-ati nyebur..').

w:-
    playerLoc(X,Y),
    Y1 is Y-1,
    retractall(playerLoc(X,Y)),
    asserta(playerLoc(X,Y1)),
    !.

s:-
    playerLoc(X,Y),
    Y1 is Y+1,
    isBorderBawah(X,Y1),
    write('Mentok gaiss..').
s:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    write('Ati-ati nyebur..').

s:-
    retractall(playerLoc(X,Y)),
    Y1 is Y+1,
    asserta(playerLoc(X,Y1)),
    !.

a:-
    playerLoc(X,Y),
    X1 is X -1,
    isBorderKiri(X1,Y),
    write('Mentok gaiss..').

a:-
    playerLoc(X,Y),
    X1 is X -1,
    waterLoc(X1,Y),
    write('Ati-ati nyebur..').
a:-
    retractall(playerLoc(X,Y)),
    X1 is X-1,
    asserta(playerLoc(X1,Y)),!.



task:-
    posisiPlayer(X,Y),
    questLoc(X,Y),
    printMap,
    quest,!.
