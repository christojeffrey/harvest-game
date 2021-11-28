% berisi dig plant dan harvest

% fact
% rule




% (seperti) sebuah fungsi yang mengembalikan true jika tile player saat ini bukanlah special tile.
isMyLocNotaSpecialTile:-
    playerLoc(MyBaris, MyKolom),
    marketPlaceLoc(MPBaris, MPKolom),
    ranchLoc(RBaris, RKolom),
    houseLoc(HBaris, HKolom),
    questLoc(QBaris, Qkolom),
    forall(diggedLoc(DBaris, Dkolom),( MyBaris \= DBaris, MyKolom \= Dkolom)),
    forall(plantedLoc(PBaris, Pkolom,_,_,_), (MyBaris \= PBaris, MyKolom \= Pkolom)),
    MyBaris \= MPBaris, MyKolom \= MPKolom,
    MyBaris \= RBaris, MyKolom \= RKolom,
    MyBaris \= HBaris, MyKolom \= HKolom,
    MyBaris \= QBaris, MyKolom \= Qkolom.


dig :-
    playerState('start'),!,
    isCommandAllowed,
    isMyLocNotaSpecialTile, !,
    findItem('shovel', ShovelDetail),
    (ShovelDetail \= [] ->(
        ShovelDetail = [_,_,ShovelLevel],
        playerLoc(MyBaris, MyKolom),
        assertz(diggedLoc(MyBaris, MyKolom)),
        write('you digged a tile.\n'),
        ((
            ShovelLevel == 1,
            addTimeByX(4)
        );(
            ShovelLevel == 2,
            addTimeByX(2)
        );(
            ShovelLevel == 3,
            addTimeByX(1)
        ))
    );(
        write('kamu tidak mempunya shovel\n')
    )).
dig :-
    write('you cannot dig this tile because it\'s a special tile!\n (or the game hasn\'t been started yet)').

plant :-
    playerState('start'),!,
    isCommandAllowed,
    playerLoc(MyBaris, MyKolom),
    diggedLoc(DBaris, Dkolom),
    DBaris = MyBaris, Dkolom = MyKolom,!,
    showAvailableSeed,
    write('what do you want to plant? (example \'corn\')\n > '),
    read(TobePlanted),
    planting(TobePlanted),
    currentDay(CD),
    currentTime(CT),
    assertz(plantedLoc(MyBaris, MyKolom, TobePlanted,CD, CT)),
    retract(diggedLoc(MyBaris, MyKolom)),
    write('you planted a '), write(TobePlanted), write(' seed.\n'),
    addTimeByX(2).

plant :-
    write('you can\'t plant on this tile!\nkalau tile belum digali, galilah dengan command dig.\n(or the game hasn\'t been started yet)').

% helper plant
showAvailableSeed :-
    write('you have :'),nl,
    helperShowAvailableSeed('corn seed'),
    helperShowAvailableSeed('carrot seed'),
    helperShowAvailableSeed('wheat seed').
    
helperShowAvailableSeed(ItemName) :-
    findItem(ItemName, ItemDetail),
    ItemDetail = [_,ItemCount,_],
    (
       ItemCount \= 0, 
        write(' - '), write(ItemCount), write(' '), write(ItemName),nl
    ;
        true
    ).

planting(ItemName) :-
    (
        ItemName = 'corn', 
        changeItemCount('corn seed', -1)
    );(
        ItemName = 'carrot',
        changeItemCount('carrot seed', -1)

    );(
        ItemName = 'wheat',
        changeItemCount('wheat seed', -1)

    ),!.
planting(_):-
    write('input tidak valid\n'), fail.


% harvest baru bisa setelah 1 hari.
harvest :-
    playerState('start'),!,
    isCommandAllowed,
    playerLoc(MyBaris, MyKolom),
    plantedLoc(PBaris, Pkolom, PlantName,PlantDay,_),
    PBaris = MyBaris, Pkolom = MyKolom,!,
    currentDay(CD),
    (PlantDay < CD  ->(
        % bisa harvest
        % sekali harvest, dapet 2 biji. generous dikit lah
        changeItemCount(PlantName, 2),
        write('kamu mendapatkan 2 buah '), write(PlantName), write('!\n'),
        retract(plantedLoc(PBaris, Pkolom, PlantName,PlantDay,PlantTime)),
        addTimeByX(2)

    );(
        % gabisa harvest
        write('belum bisa harvest, tunggulah beberapa jam atau hari berlalu.\n')
    )).
harvest :-
    write('you can\'t harvest this tile!\nkalau belum ditanam,gunakan command plant.\n(or the game hasn\'t been started yet)').

