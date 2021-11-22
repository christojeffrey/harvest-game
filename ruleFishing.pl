:- include('globalFact.pl').
:- include('globalRule.pl').

:- dynamic().


fishing:-
    playerLoc(X,Y),
    X1 is X-1,
    waterLoc(X1,Y),
    goFishing,!.

fishing:-
    playerLoc(X,Y),
    X1 is X+1,
    waterLoc(X1,Y),
    goFishing,!.

fishing:-
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    goFishing,!.

fishing:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    goFishing,!.

goFishing(X):-
    levelFishing(1),
    1 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == tuna,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    inventoryList([NamaIkan JumlahBaru Level]).