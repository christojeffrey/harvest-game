fish:-
    playerLoc(X,Y),
    X1 is X-1,
    waterLoc(X1,Y),
    random(0,8,Z),
    goFishing(Z),!.

fish:-
    playerLoc(X,Y),
    X1 is X+1,
    waterLoc(X1,Y),
    random(0,8,Z),
    goFishing(Z),!.

fish:-  
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    random(0,8,Z),
    goFishing(Z),!.

fish:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    random(0,8,Z),
    goFishing(Z),!.
fish:-
    write('Maaf kamu tidak berada di dekat air, Pergi ke tempat air untuk memancing!!!'),
    nl,
    !.

goFishing(_):-
    findItem(EqName, TheItem),
    TheItem \== [], TheItem  = [TheItemName, TheItemCount, _], 
    TheItemCount <1,
    write('Maaf kamu ga punya fishing rod!!'),nl,
    write('Beli di Market dulu'),nl,
    !.

goFishing(_):-
    levelFishing(_),
    totalItemCount(Total),
    Total=:=100,
    write('Item penuh, kosongkan inventory terlebih dahulu!'),
    nl,!.

%nilai 0-3 Zonk, 4-6 Tuna, 7-8 Salmon, 9=< catfish
goFishing(X):-
    class(Class),
    Class == 'fisherman',
    levelFishing(Z),
    X1 is X+Z,
    X1 < 4,
    random(2,5,J),
    addTimeByX(J),
    write('Sepertinya ikanmu kabur, kamu kurang beruntung!'),
    nl,!.

goFishing(X):-
    class(Class),
    Class == 'fisherman',
    levelFishing(Z),
    Z<4,
    X1 is X+Z,
    X1 >3,
    X1<7,
    random(1,3,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),nl,
    write(' __v_'),nl,
    write('(____ /{'),nl,
    Z1 is Z+15,
    asserta(expFishing(Z1)), 
    changeItemCount('tuna',1),!.

goFishing(X):-
    class('fisherman'),
    levelFishing(L),
    X1 is X+L,
    X1>6,
    X1<9,
    random(2,4,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Salmon!!'),
    nl,
    write('        /\\ '),nl,
    write('      _/./  '),nl,
    write('   ,-|    `-:.,-/ '),nl,
    write('  > O )<)    _  ('),nl,
    write('  `-._  _.:\' `-.\\ '),nl,
    write('     `` \\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+30,
    asserta(expFishing(Z1)), 
    changeItemCount('salmon',1),!.

goFishing(X):-
    class('fisherman'),
    levelFishing(L),
    L>2,
    X1 is X+3,
    X1>8,
    random(3,5,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Catfish!!'),
    nl,
    write('          /"*._         _'),nl,
    write('      .-*\'`    `*-.._.-\'/'),nl,
    write('    < * ))     ,       ( '),nl,
    write('      `*-._`._(__.--*"`.\\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+40,
    asserta(expFishing(Z1)),   
    changeItemCount('catfish',1),!.

%Memancing jika dia seorang fishbiasaer
goFishing(X):-
    levelFishing(Y),
    Y>3,
    X1 is X+Y,
    X1 >3,
    X1<7,
    random(2,3,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),nl,
    write(' __v_'),nl,
    write('(____ /{'),nl,
    Z1 is Z+10,
    retractall(expFishing(Z)),
    asserta(expFishing(Z1)), 
    changeItemCount('tuna',1),!.

goFishing(X):-
    levelFishing(Y),
    Y>3,
    X1 is X+Y,
    X1>6,
    X1<9,
    random(2,4,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Salmon!!'),
    nl,
    write('        /\\ '),nl,
    write('      _/./  '),nl,
    write('   ,-|    `-:.,-/ '),nl,
    write('  > O )<)    _  ('),nl,
    write('  `-._  _.:\' `-.\\ '),nl,
    write('     `` \\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+25,
    asserta(expFishing(Z1)), 
    changeItemCount('salmon',1),!.

goFishing(X):-
    levelFishing(Y),
    Y>3,
    X1 is X+Y,
    X1>8,
    random(3,6,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Catfish!!'),
    nl,
    write('          /"*._         _'),nl,
    write('      .-*\'`    `*-.._.-\'/'),nl,
    write('    < * ))     ,       ( '),nl,
    write('      `*-._`._(__.--*"`.\\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+35,
    asserta(expFishing(Z1)),   
    changeItemCount('catfish',1),!.

%Jika dia orang lain


goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1 >3,
    X1<7,
    addTimeByX(3),
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),nl,
    write(' __v_'),nl,
    write('(____ /{'),nl,
    Z1 is Z+5,
        retractall(expFishing(Z)), 
    asserta(expFishing(Z1)), 
    changeItemCount('tuna',1),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>6,
    X1<9,
    addTimeByX(4),
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    write('        /\\ '),nl,
    write('      _/./  '),nl,
    write('   ,-|    `-:.,-/ '),nl,
    write('  > O )<)    _  ('),nl,
    write('  `-._  _.:\' `-.\\ '),nl,
    write('     `` \\ '),nl,
        retractall(expFishing(Z)), 
    Z1 is Z+15,
    asserta(expFishing(Z1)), 
    changeItemCount('salmon',1),!.

goFishing(X):-
    levelFishing(Y),
    X1 is X+Y,
    X1>=9,
    addTimeByX(5),
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),
    nl,
    write('          /"*._         _'),nl,
    write('      .-*\'`    `*-.._.-\'/'),nl,
    write('    < * ))     ,       ( '),nl,
    write('      `*-._`._(__.--*"`.\\ '),nl,
    retractall(expFishing(Z)),
    Z1 is Z+30,
    asserta(expFishing(Z1)),   
    changeItemCount('catfish',1),!.


