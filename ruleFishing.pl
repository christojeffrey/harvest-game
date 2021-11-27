:- include('globalFact.pl').
:- include('globalRule.pl').

:- dynamic().


fishing:-
    playerLoc(X,Y),
    X1 is X-1,
    waterLoc(X1,Y),
    random(1,8,Z)  
    goFishing(Z),!.

fishing:-
    playerLoc(X,Y),
    X1 is X+1,
    waterLoc(X1,Y),
    random(1,8,Z)  
    goFishing(Z),!.

fishing:-
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    random(1,8,Z)  
    goFishing(Z),!.

fishing:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    random(1,8,Z),
    goFishing(Z),!.

goFishing(X):-
    levelFishing(1),
    1 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == tuna,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.

goFishing(X):-
    levelFishing(1),
    0 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == salmon,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.


goFishing(X):-
    levelFishing(2),
    0 is X mod 3,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == catfish,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.


goFishing(X):-
    levelFishing(2),
    1 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == tuna,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.

goFishing(X):-
    levelFishing(2),
    0 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == salmon,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.

goFishing(X):-
    levelFishing(3),
    0 is X mod 3,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == catfish,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.


goFishing(X):-
    levelFishing(3),
    1 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == tuna,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.

goFishing(X):-
    levelFishing(3),
    0 is X mod 2,
    inventoryList([NamaIkan JumlahIkan Level]),
    NamaIkan == salmon,
    JumlahBaru is JumlahIkan+1,
    retract(inventoryList([NamaIkan JumlahIkan Level])),
    aserta(inventoryList([NamaIkan JumlahBaru Level])),!.
