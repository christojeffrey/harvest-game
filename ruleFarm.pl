% berisi dig plant dan harvest

% fact
% rule




% (seperti) sebuah fungsi yang mengembalikan true jika tile player saat ini bukanlah special tile.
isMyLocNotaSpecialTile:-
    playerLoc(MyX, MyY),
    marketPlaceLoc(MPX, MPY),
    ranchLoc(RX, RY),
    houseLoc(HX, HY),
    questLoc(QX, QY),
    forall(diggedLoc(DX, DY),(MyX \= DX ; MyY \= DY)),
    forall(plantedLoc(PX, PY,_,_,_), (MyX \= PX; MyY \= PY)),
    (MyX \= MPX; MyY \= MPY),
    (MyX \= RX; MyY \= RY),
    (MyX \= HX; MyY \= HY),
    (MyX \= QX;  MyY \= QY).


dig :-
    playerState('start'),
    write('command is allowed'),nl,
    isMyLocNotaSpecialTile,!,
    isCommandAllowed,
    findItem('shovel', ShovelDetail),
    ShovelDetail = [_,ShovelCount,ShovelLevel],
    (ShovelCount \= 0 ->(
        playerLoc(MyX, MyY),
        assertz(diggedLoc(MyX, MyY)),
        write('you digged a tile.\n'),!,
        digTime(ShovelLevel)

    );(
        write('kamu tidak mempunya shovel\n')
    )).
dig :-
    write('you cannot dig this tile because it\'s a special tile!\n (or the game hasn\'t been started yet)').


digTime(ShovelLevel) :-
    ShovelLevel == 1,!,
    addTimeByX(4).
digTime(ShovelLevel) :-
    ShovelLevel == 2,!,
    addTimeByX(2).
digTime(ShovelLevel) :-
    ShovelLevel == 3,!,
    addTimeByX(1).

plant :-
    playerState('start'),
    playerLoc(MyX, MyY),
    diggedLoc(MyX, MyY),!,
    isCommandAllowed,
    showAvailableSeed,
    write('what do you want to plant? (example \'corn\')\n> '),
    read(TobePlanted),
    planting(TobePlanted),
    currentDay(CD),
    currentTime(CT),
    assertz(plantedLoc(MyX, MyY, TobePlanted,CD, CT)),
    retract(diggedLoc(MyX, MyY)),
    write('you planted a '), write(TobePlanted), write(' seed.\n'),
    addTimeByX(2).

plant :-
    write('you can\'t plant on this tile!\nkalau tile belum digali, galilah dengan command dig.\n(or the game hasn\'t been started yet)').

% helper plant
showAvailableSeed :-
    write('you have :'),nl,
    helperShowAvailableSeed('corn seed'),
    helperShowAvailableSeed('carrot seed'),
    helperShowAvailableSeed('wheat seed'),!.
    
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
    ItemName = 'corn', 
    changeItemCount('corn seed', -1),!.

planting(ItemName) :-
    ItemName = 'carrot',
    changeItemCount('carrot seed', -1),!.

planting(ItemName) :-
    ItemName = 'wheat',
    changeItemCount('wheat seed', -1),!.
planting(_):-
    write('input tidak valid\n'), fail.


% harvest baru bisa setelah 1 hari.
harvest :-
    playerState('start'),
    isCommandAllowed,
    playerLoc(MyX, MyY),
    plantedLoc(PX, PY, PlantName,PlantDay,_),
    PX = MyX, PY = MyY,!,
    currentDay(CD),
    (PlantDay < CD  ->(
        % bisa harvest
        % sekali harvest, dapet 2 biji. generous dikit lah
        changeItemCount(PlantName, 2),
        write('kamu mendapatkan 2 buah '), write(PlantName), write('!\n'),
        retract(plantedLoc(PX, PY, PlantName,PlantDay,_)),
        addTimeByX(2)

    );(
        % gabisa harvest
        write('belum bisa harvest, tunggulah beberapa jam atau hari berlalu.\n')
    )).
harvest :-
    write('you can\'t harvest this tile!\nkalau belum ditanam,gunakan command plant.\n(or the game hasn\'t been started yet)').

