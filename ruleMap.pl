% digunakan untuk menampilkan map, dan untuk berpindah.

% include fakta global
%:- include('globalFact.pl').

%map :- write('ini map').

%w :- %write('kamu bergerak ke arah utara sebanyak 1 tile').
%a :- %write('kamu bergerak ke arah barat sebanyak 1 tile').
%s :- %write('kamu bergerak ke arah selatan sebanyak 1 tile').
%d :- %write('kamu bergerak ke arah timur sebanyak 1 tile').

initMap:-
    random(10,20,X),
    random(10,20,Y),
    retract(lebarMap(_)),
    asserta(lebarMap(X)),
    retract(tinggiMap(_))
    asserta(tinggiMap(Y)),    
    retract(playerLoc(_,_)),
    asserta(playerLoc(1,1)),
    generateLand.

generateLand:-
    asserta(questLoc(4,7)),
    asserta(marketPlaceLoc(7,7)),
    asserta(ranchLoc(3,3)),
    asserta(houseLoc(5,5)),

    asserta(waterLoc(3,9)),
    asserta(waterLoc(2,9)),
    asserta(waterLoc(4,9)),
    asserta(waterLoc(4,8)),
    asserta(waterLoc(3,7)).

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
    Xmax is L+1,
    Ymax is T+1,
    forall(between(Y, Ymax, I),(
        forall(between(X,Xmax,J),(
            printCoord(I,J)
        )),
        nl,
    )),
    !.

map:-
    retract(questLoc(_,_)),
    retract(houseLoc(_,_)),
    retract(marketPlaceLoc(_,_)),
    retract(ranchLoc(_,_)),
    retract(waterLoc(_,_)),
    retract(diggedLoc(_,_)),
    initMap,
    printMap,
    printLegend,
    !.

w:-
    playerLoc(X,Y),
    Y1 is Y-1,
    isBorderAtas(X,Y1),!.
w:-
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),!.

w:-
    retract(playerLoc(X,Y)),
    Y1 is Y-1,
    asserta(posisiPlayer(X,Y1)),
    task.

s:-
    playerLoc(X,Y),
    Y1 is Y+1,
    isBorderBawah(X,Y1),!.
s:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),!.

s:-
    retract(playerLoc(X,Y)),
    Y1 is Y+1,
    asserta(posisiPlayer(X,Y1)),
    task.

a:-
    playerLoc(X,Y),
    X1 is X -1,
    isBorderKiri(X1,Y),
    !.

a:-
    playerLoc(X,Y),
    X1 is X -1,
    waterLoc(X1,Y),
    !.
a:-
    retract(playerLoc(X,Y)),
    X1 is X-1,
    asserta(posisiPlayer(X1,Y)),
    task.

d:-
    playerLoc(X,Y),
    X1 is X +1,
    isBorderKiri(X1,Y),
    !.

d:-
    playerLoc(X,Y),
    X1 is X +1,
    waterLoc(X1,Y),
    !.
d:-
    retract(playerLoc(X,Y)),
    X1 is X+1,
    asserta(posisiPlayer(X1,Y)),
    task.

task:-
    posisiPlayer(X,Y),
    questLoc(X,Y),
    printMap,
    quest,!.

task:-.


resetMap:-.
