:- include('globalFact.pl').
:- include('globalRule.pl').


fishing:-
    playerLoc(X,Y),
    X1 is X-1,
    waterLoc(X1,Y),
    random(0,8,Z),
    goFishing(Z),!.

fishing:-
    playerLoc(X,Y),
    X1 is X+1,
    waterLoc(X1,Y),
    random(0,8,Z),
    goFishing(Z),!.

fishing:-  
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    random(0,8,Z),
    goFishing(Z),!.

fishing:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    random(0,8,Z),
    goFishing(Z),!.

fishing:-
    write('Maaf kamu tidak berada di dekat air, Pergi ke tempat air untuk memancing!!!'),
    nl,
    !.

%nilai 0-3 Zonk, 4-6 Tuna, 7-8 Salmon, 9=< catfish
goFishing(X):-
    levelFishing(1),
    X1 is X+1,
    X1 < 4,
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

goFishing(X):-
    levelFishing(2),
    X1 is X+2,
    X1 < 4,
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

goFishing(X):-
    levelFishing(3),
    X1 is X+3,
    X1 < 4,
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

goFishing(X):-
    levelFishing(_),
    totalItemCount(Total),
    Total=:=100,
    write('Item penuh, kosongkan inventory terlebih dahulu!'),
    nl,!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1 >=4,
    X1<=6,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    changeItemCount('Tuna',1),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>6,
    X1<9,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    changeItemCount('Salmon',1),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>=9,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    changeItemCount('Catfish',1),!.


    
