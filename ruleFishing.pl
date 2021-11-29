fish:-
    playerLoc(X,Y),
    X1 is X-1,
    waterLoc(X1,Y),
    random(0,8,Z),
    isCommandAllowed,
    goFishing(Z),!.

fish:-
    playerLoc(X,Y),
    X1 is X+1,
    waterLoc(X1,Y),
    random(0,8,Z),
    isCommandAllowed,
    goFishing(Z),!.

fish:-  
    playerLoc(X,Y),
    Y1 is Y-1,
    waterLoc(X,Y1),
    random(0,8,Z),
    isCommandAllowed,
    goFishing(Z),!.

fish:-
    playerLoc(X,Y),
    Y1 is Y+1,
    waterLoc(X,Y1),
    random(0,8,Z),
    isCommandAllowed,
    goFishing(Z),!.
fish:-
    isCommandAllowed,
    write('Maaf kamu tidak berada di dekat air, Pergi ke tempat air untuk memancing!!!'),
    nl,
    !.

fish:-
    write('Sudah malam, jangan memancing, bahaya jika tertidur di air'),nl.

goFishing(_):-
    findItem(_, TheItem),
    TheItem \== [], TheItem  = [_, TheItemCount, _], 
    TheItemCount <1,
    write('Maaf kamu ga punya fishing rod!!'),nl,
    write('Beli di Market dulu'),nl,
    !.

goFishing(_):-
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
    addFishingEXPByX(15),
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
    addFishingEXPByX(30),
    changeItemCount('salmon',1),!.

goFishing(X):-
    class('fisherman'),
    levelFishing(L),
    L>1,
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
    addFishingEXPByX(40),   
    changeItemCount('catfish',1),!.

%Memancing jika dia seorang fishbiasaer
goFishing(X):-
    levelFishing(Y),
    Y>1,
    X1 is X+Y,
    X1 >3,
    X1<7,
    random(2,3,J),
    addTimeByX(J),
    write('Selamat kamu berhasil memancing sebuah Tuna!!'),nl,
    write(' __v_'),nl,
    write('(____ /{'),nl,
    addFishingEXPByX(10), 
    changeItemCount('tuna',1),!.

goFishing(X):-
    levelFishing(Y),
    Y>1,
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
    addFishingEXPByX(25), 
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
    addFishingEXPByX(35),   
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
    addFishingEXPByX(5),
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
    addFishingEXPByX(15), 
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
    addFishingEXPByX(30),  
    changeItemCount('catfish',1),!.


