:- include('globalFact.pl').
:- include('globalRule.pl').

fish:-
    playerLoc(X,Y),
    X1 is X-1,
    waterLoc(X1,Y),
    random(0,8,Z),
    currentTime(T),
    T1 is T+20,
    retractall(currentTime(T)),
    asserta(currentTime(T1)),
    goFishing,!.

fish:-
    playerLoc(X,Y),
    X1 is X+1,
    waterLoc(X1,Y),
    random(0,8,Z),
    currentTime(T),
    T1 is T+20,
    retractall(currentTime(T)),
    asserta(currentTime(T1)),
    goFishing,!.
fish:-  
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    random(0,8,Z),
    currentTime(T),
    T1 is T+20,
    retractall(currentTime(T)),
    asserta(currentTime(T1)),
    goFishing,!.

fish:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    random(0,8,Z),
    currentTime(T),
    T1 is T+20,
    retractall(currentTime(T)),
    asserta(currentTime(T1)),
    goFishing,!.

fish:-
    write('Maaf kamu tidak berada di dekat air, Pergi ke tempat air untuk memancing!!!'),
    nl,
    !.

goFishing(X):-
    findItem(ItName, TheItem),
    TheItem \== [], TheItem  = [TheItemName, TheItemCount, _], 
    TheItemCount <1,
    write('Maaf kamu ga punya fishing rod!!'),nl,
    write('Beli di Market dulu'),nl,
    !.

goFishing(X):-
    levelFishing(_),
    totalItemCount(Total),
    Total=:=100,
    write('Item penuh, kosongkan inventory terlebih dahulu!'),
    nl,!.

%nilai 0-3 Zonk, 4-6 Tuna, 7-8 Salmon, 9=< catfish
goFishing(X):-
    class(fisherman),
    levelFishing(1),
    X1 is X+2,
    X1 < 4,
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

goFishing(X):-
    class(fisherman),
    levelFishing(2),
    X1 is X+3,
    X1 < 4,
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

goFishing(X):-
    class(fisherman),
    levelFishing(3),
    X1 is X+4,
    X1 < 4,
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

%Memancing jika dia seorang fisher
goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1 >=4,
    X1<=6,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),nl,
    write(' __v_'),nl,
    write('(____\ /{'),nl,
    Z1 is Z+45,
    asserta(expFishing(Z1)), 
    changeItemCount('tuna',1),
    asserta(levelFishing(Y1)),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>6,
    X1<9,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    write('        /\\ '),nl,
    write('      _/./  '),nl,
    write('   ,-|    `-:.,-/ '),nl
    write('  > O )<)    _  ('),nl,
    write('  `-._  _.:\' `-.\\ '),nl,
    write('     `` \\ '),nl,
    Z1 is Z+75,
    asserta(expFishing(Z1)), 
    changeItemCount('salmon',1),
    asserta(levelFishing(Y1)),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>=9,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    write('          /"*._         _'),nl,
    write('      .-*'`    `*-.._.-'/'),nl,
    write('    < * ))     ,       ( '),nl,
    write('      `*-._`._(__.--*"`.\\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+130,
    asserta(expFishing(Z1)),   
    changeItemCount('catfish',1),
    asserta(levelFishing(Y1)),!.

%Jika dia orang lain


goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1 >=4,
    X1<=6,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),nl,
    write(' __v_'),nl,
    write('(____\ /{'),nl,
    Z1 is Z+25,
    asserta(expFishing(Z1)), 
    changeItemCount('tuna',1),
    asserta(levelFishing(Y1)),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>6,
    X1<9,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    write('        /\\ '),nl,
    write('      _/./  '),nl,
    write('   ,-|    `-:.,-/ '),nl
    write('  > O )<)    _  ('),nl,
    write('  `-._  _.:\' `-.\\ '),nl,
    write('     `` \\ '),nl,
    Z1 is Z+50,
    asserta(expFishing(Z1)), 
    changeItemCount('salmon',1),
    asserta(levelFishing(Y1)),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>=9,
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    write('          /"*._         _'),nl,
    write('      .-*'`    `*-.._.-'/'),nl,
    write('    < * ))     ,       ( '),nl,
    write('      `*-._`._(__.--*"`.\\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+100,
    asserta(expFishing(Z1)),   
    changeItemCount('catfish',1),
    asserta(levelFishing(Y1)),!.


checkLevelFishing(X):-
    X>500,
    levelFishing(Y),
    Y1 is Y+1,
    write('*===============+=+============||=============+=+=========*'),nl,
    write('Selamat kamu nail level, sekarang kamu memiki fishing level'),
    write(Y1),
    write('.'),nl,
    write('*===============+=+============||=============+=+=========*'),nl,
    retractall(levelFishing(_)),
    asserta(levelFishing(Y1)),!.

checkLevelFishing(X):-
    X>1000,
    levelFishing(Y),
    Y1 is Y+1,
    write('*===============+=+============||=============+=+=========*'),nl,
    write('Selamat kamu nail level, sekarang kamu memiki fishing level'),
    write(Y1),
    write('.'),nl,
    write('*===============+=+============||=============+=+=========*'),nl,
    retractall(levelFishing(_)),
    asserta(levelFishing(Y1)),!.


    
