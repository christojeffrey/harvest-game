% untuk menyimpan rule yang relaitf umum dan bisa digunakan untuk lebih dari satu command
% :- include('globalFact.pl').

% rule untuk input

% dibuat sama gede

% Untuk mengecek input, bisa dipake buat input apa aja tbh
% Question itu isinya string buat minta query
% Input itu isinya nama variabel yang bakal nyimpen inputnya
% Comparison itu isinya fact/rule buat ngecek Input valid atau engga
% ErrorMessage itu ditampilin kalau Input tidak sesuai Comparison
checkInput(Question, Input, Comparison, ErrorMessage) :-
    repeat,
        format('~w:~n', [Question]),
        read(Input),
        (   call(Comparison, Input)
        ->  true, !
        ;   format('ERROR: ~w:~n', [ErrorMessage]),
            fail
        ).

% rule untuk menambah Gold

addGoldbyX(X) :-
    retract(gold(CurrentGold)),
    NewGold is CurrentGold + X,
    assertz(gold(NewGold)).

subtractGoldbyX(X) :-
    retract(gold(CurrentGold)),
    NewGold is CurrentGold - X,
    assertz(gold(NewGold)).

% rule untuk menambah EXP (asumsi masukan EXP selalu valid ya)

addMainEXPByX(X) :-
    retract(exp(CurrentEXP)),
    NewEXP is CurrentEXP + X,
    assertz(exp(NewEXP)),
    checkMainEXP.

addFarmingEXPByX(X) :-
    retract(expFarming(CurrentEXP)),
    NewEXP is CurrentEXP + X,
    assertz(expFarming(NewEXP)),
    checkFarmingEXP.

addFishingEXPByX(X) :-
    retract(expFishing(CurrentEXP)),
    NewEXP is CurrentEXP + X,
    assertz(expFishing(NewEXP)),
    checkFishingEXP.

addRanchingEXPByX(X) :-
    retract(expRanching(CurrentEXP)),
    NewEXP is CurrentEXP + X,
    assertz(expRanching(NewEXP)),
    checkRanchingEXP.

checkMainEXP :-
    exp(MainEXP),
    retract(level(_)),
    FloatNew is MainEXP/100,
    NewLevel is ceiling(FloatNew),
    write('Level kamu saat ini adalah '), write(NewLevel),
    assertz(level(NewLevel)).

checkFishingEXP :-
    expFishing(FishingEXP),
    retract(levelFishing(_)),
    FloatNew is FishingEXP/100,
    NewLevel is ceiling(FloatNew),
    write('Level fishing kamu saat ini adalah '), write(NewLevel),
    assertz(levelFishing(NewLevel)).

checkFarmingEXP :-
    expFarming(FarmingEXP),
    retract(levelFarming(_)),
    FloatNew is FarmingEXP/100,
    NewLevel is ceiling(FloatNew),
    write('Level farming kamu saat ini adalah '), write(NewLevel),
    assertz(levelFarming(NewLevel)).

checkRanchingEXP :-
    expRanching(RanchingEXP),
    retract(levelRanching(_)),
    FloatNew is RanchingEXP/100,
    NewLevel is ceiling(FloatNew),
    write('Level ranching kamu saat ini adalah '), write(NewLevel),
    assertz(levelRanching(NewLevel)).
    
% rule untuk mengurangi waktu ranching
reduceOrRemoveCowCooldown :-
    retract(cowCooldown(Timer)),
    ((Timer > 1, NewTimer is Timer - 1, assertz(cowCooldown(NewTimer)));
    (Timer =< 1, assertz(cowCooldown(0)))).

reduceOrRemoveSheepCooldown :-
    retract(sheepCooldown(Timer)),
    ((Timer > 1, NewTimer is Timer - 1, assertz(sheepCooldown(NewTimer)));
    (Timer =< 1, assertz(sheepCooldown(0)))).

reduceOrRemoveChickenCooldown :-
    retract(chickenCooldown(Timer)),
    ((Timer > 1, NewTimer is Timer - 1, assertz(chickenCooldown(NewTimer)));
    (Timer =< 1, assertz(chickenCooldown(0)))).

%rule untuk time

% menambahkan time sebanyak X(yaitu input)
addTimeByX(X) :- 
    retract(currentTime(Timenow)), 
    Timenew is Timenow + X,  
    assertz(currentTime(Timenew)).


% melakukan pengecekan apakah suatu perintah dapat dilakukan, berdasarkan time saat ini.
% jika suatu perintah diperbolehkan(artinya 'hari belum habis'), maka command akan diteruskan.
% jika suatu perintah tidak diperbolehkan, maka akan memberikan print keterangan untuk menyuruh player untuk tidur. lalu dan diakhiri dengan fail agar command tidak bisa diteruskan.

% contoh penggunaan
% ruleFly :-
%     isCommandAllowed,
%     addTimeByX(2),
%     command2 yang berhubungan dengan farm.

% jangan pake isCommandAllowed di move w a s d ya, nti dia gabisa pulang :v

% untuk saat ini, batas time dalam satu hari adalah 22 (kek 22.00, jam 10 malem jam)
isCommandAllowed :-
    currentTime(X), 
    X >= 24,!, write('harimu sudah habis! kerumah trus bobok yah\n'), fail.
isCommandAllowed :-
    true.


% -----rule untuk item-----

% (seperti) fungsi untuk menjumlahkan dari masing-masing item. (seperti) mengembalikan nilai Hasil, yaitu total semua hal di bagian item.
totalItemCount(Hasil):-
    items(AllItems),
    helperTotalItemCount(AllItems, Hasil).

% fungsi perantara totalItemCount
helperTotalItemCount(ItemList, Hasil) :-
    ItemList = [], Hasil = 0, !.
helperTotalItemCount(ItemList, Hasil) :-
    ItemList = [H | T], helperTotalItemCount(T, HasilPrev), H = [_,ItemCount,_], Hasil is HasilPrev + ItemCount.


% (seperti) prosedur untuk mencari Equipment EqName, lalu menambahkan sebanyak AmountAdded pada bagian levelnya(AmountAdded bisa bernilai negatif). equipment harus ada di dalam item list. kalau eqName tidak ada, fungsi gabakal ngelakuin apa2. 

% salah satu penggunaan, bisa dipake di market
changeItemLevel(EqName, AmountAdded) :-
    findItem(EqName, TheItem),
    TheItem \== [], TheItem  = [TheItemName, TheItemCount, TheItemLevel], 
    NewLevel is TheItemLevel + AmountAdded,
    items(AllItems),
    length(AllItems, Panjang),
    helperChangeItemCountOrLevel(Panjang, AllItems, [TheItemName, TheItemCount, NewLevel],ItemListNew),
    retract(items(_)),
    assertz(items(ItemListNew)).


% (seperti) prosedur untuk mencari Equipment EqName, lalu menambahkan sebanyak AmountAdded pada bagian count(AmountAdded bisa bernilai negatif). equipment harus ada di dalam item list. kalau eqName tidak ada, fungsi gabakal ngelakuin apa2. 

% salah satu penggunaan, bisa dipake di market
changeItemCount(ItName, AmountAdded) :-
    findItem(ItName, TheItem),
    TheItem \== [], TheItem  = [TheItemName, TheItemCount, TheItemLevel], 
    NewCount is TheItemCount + AmountAdded,
    items(AllItems),
    length(AllItems, Panjang),
    helperChangeItemCountOrLevel(Panjang, AllItems, [TheItemName, NewCount, TheItemLevel],ItemListNew),
    retract(items(_)),
    assertz(items(ItemListNew)).

helperChangeItemCountOrLevel(Counter, _, _, ItemListNew) :-
    Counter = 0 , ItemListNew = [],!.

helperChangeItemCountOrLevel(Counter, ItemList, NewItem, ItemListNew) :-
    NewCounter is Counter - 1, 
    helperChangeItemCountOrLevel(NewCounter, ItemList, NewItem, ItemListNewPrev),
    nth1(Counter, ItemList, ItemAtCounter), 
    ItemAtCounter = [NameIAC, _, _], 
    NewItem = [NameNI, _, _],
    (NameIAC = NameNI -> 
        append(ItemListNewPrev, [NewItem], ItemListNew);
        append(ItemListNewPrev, [ItemAtCounter], ItemListNew)
    ).


% (seperti) fungsi untuk mencari ItemName, lalu mengembalikan item tersebut lengkap dengan count dan level. mengembalikan list kosong jika nama tidak ada. Hanya untuk mendapatkan info. 
% contoh
% findItem('corn', CornItem).
% CornItem = ['corn', 1, 0]. 
% findItem('titit gajah', ItemTititGajah).
% ItemTititGajah = [].
% iya nama itemnya gitu, santai dikit lah jangan tegang
% contoh penggunaan : bisa dipake buat ngecek level sebuah item, buat nentuin efeknya.

findItem(ItemName, ItemNameCountLevel) :-
    items(AllItems),
    helperFindItem(ItemName, AllItems, ItemNameCountLevel).

helperFindItem(_, ItemList, ItemNameCountLevel) :-
    ItemList = [], ItemNameCountLevel = [],!. 

helperFindItem(ItemNameQuery, ItemList, ItemNameCountLevel) :-
    ItemList = [H | T], H = [ItemName, _, _],
    (ItemName = ItemNameQuery -> ItemNameCountLevel = H; helperFindItem(ItemNameQuery, T, ItemNameCountLevel)). 


% rule untuk fail dan goal state. 
% goal state digunakan setiap kali player mendapatkan uang
goalState :-
    gold(Gold),
    Gold >= 20000 ->(
        write('uang kamu telah mencapai 20.000!'),nl,
        write('selamat, kamu telah berhasil membayar semua hutangmu!'),nl,
        resetAllState
    );(
        true
    ).
% untuk melakukan reset semua dynamic fact di globalFact tapi belom dibikin. agak nguli.
resetAllState :-
    retractall(playerState(_)),
    retractall(level(_)),
    retractall(levelFarming(_)),
    retractall(levelFishing(_)),
    retractall(levelRanching(_)),
    retractall(expFarming(_)),
    retractall(expFishing(_)),
    retractall(expRanching(_)),
    retractall(gold(_)),
    retractall(exp),
    retractall(currentDay(_)),
    retractall(currentTime(_)),
    retractall(items(_)),
    retractall(lebarMap(_)),    
    retractall(tinggiMap(_)),
    retractall(playerLoc(_,_)),
    retractall(questLoc(_,_)),
    retractall(marketPlaceLoc(_,_)),
    retractall(ranchLoc(_,_)),
    retractall(houseLoc(_,_)),
    retractall(waterLoc(_,_)),
    retractall(diggedLoc(_,_)),
    retractall(plantedLoc(_,_,_,_,_)).