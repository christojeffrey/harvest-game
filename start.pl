% set semua variabel terjadi di rule ini

% Include file global
:- include('globalFact.pl').
:- include('globalRule.pl').
:- include('ruleFishing.pl').
% Fact untuk Comparison Input Class
checkClass(1).
checkClass(2).
checkClass(3).
% fact buat nyatet nama2 barang yang ada
barangAndEquipmentNameList(['fishing rod', 'shovel', 'tuna', 'salmon', 'catfish', 'corn seed', 'carrot seed', 'wheat seed', 'corn', 'carrot', 'wheat', 'wool', 'egg', 'milk', 'chicken', 'cow', 'sheep']).
:- dynamic(playerName/1).
% Rules

% Start
start :- 
    playerState('startGame'),!,
    reset,
    write('masukkan nama kamu!\n> '),
    read(Name),assertz(playerName(Name)),
    write('Hai '),write(Name),write(', yuk jangan meninggoy. Pilih pekerjaanmu!'), nl,
    write('1. Farmer'), nl,
    write('2. Fisherman'), nl,
    write('3. Rancher'), nl,
    checkInput('Pilih Class anda dengan menginput nomornya disini: ', Class, checkClass, 'Invalid Input!'),
    getClass(Class). 
start :- write('kamu belum start game atau kamu sudah bermain!.\n coba masukkan perintah startGame untuk memulai atau exitGame untuk keluar.\n').

% buat nge assert yang basic(selain yg tergantung Class)
% dipisah aja biar rapi
assertBasic :-
    assertz(level(0)),
    assertz(levelFarming(0)),
    assertz(levelFishing(0)),
    assertz(levelRanching(0)),
    assertz(expFarming(0)),
    assertz(expFishing(0)),
    assertz(expRanching(0)),
    assertz(gold(0)),
    assertz(exp(0)),
    setInventory,
    initMap,
    assertz(currentDay(1)),
    % current time 7, kek dari jam 7 pagi. total waktunya sampe 24 nti
    assertz(currentTime(7)).
    
% buat assert item
setInventory :-
    assertz(items([])),
    barangAndEquipmentNameList(ItemNameList),
    initializingItems(ItemNameList).


initializingItems(List) :-
    List = [],!.
initializingItems(List) :-
    List = [H|T], items(Prev), append(Prev,[[H,0,0]], New), retract(items(_)), assertz(items(New)), initializingItems(T).

% buat assert map and loc
initMap:-
        write('success init map'),
    random(10,20,X),
    random(15,20,Y),
    retractall(lebarMap(_)),
    asserta(lebarMap(X)),
    retractall(tinggiMap(_)),
    asserta(tinggiMap(Y)), 
    retractall(playerLoc(_,_)),
    retractall(questLoc(_,_)),
    retractall(marketPlaceLoc(_,_)),
    retractall(ranchLoc(_,_)),
    retractall(houseLoc(_,_)),
    retractall(waterLoc(_,_)),
    generateLand,!.

generateLand:-
    lebarMap(X),
    tinggiMap(Y),
    L is div(X,2),
    T is div(Y,2),
    T1 is T+2,
    L1 is X-3,
    T2 is Y-3,
    asserta(questLoc(L,T2)),
    asserta(waterLoc(_,1)),
    asserta(marketPlaceLoc(L1,T1)),
    asserta(ranchLoc(3,3)),
    asserta(houseLoc(L,T)),
    asserta(playerLoc(L,T)),
    asserta(waterLoc(3,9)),
    asserta(waterLoc(2,9)),
    asserta(waterLoc(4,9)),
    asserta(waterLoc(3,10)),
    asserta(waterLoc(4,8)),
    asserta(waterLoc(3,8)),
    asserta(waterLoc(3,7)),!.

% Ini buat assertz Classnya
getClass(Class) :-
    ((Class == 1, assertz(class(farmer)));
    (Class == 2, assertz(class(fisherman)));
    (Class == 3, assertz(class(rancher)))),
    assertBasic,
    write('Selamat '), playerName(Name), write(Name), write('! Anda sekarang adalah seorang '),
    class(X), write(X),nl,
    retract(playerState(_)),
    classPerk,
    assertz(playerState('start')),
    write('\ngunakan command help untuk mengetahui semua hal yang bisa kamu lakukan!\n coba ketikkan map.\n').


% Ini buat reset dan retract Classnya
reset :- retract(class(_)), fail.
reset.

% command untuk memberikan perk tergantung kelas yang dia pilih.
% farmer mendapat shovel level 1, dan 3 buah seed corn
% fisherman mendapat fishing rod, dan 2 buah salmon
% rancher mendapatkan 3 buah chicken dan 1 buah cow.
classPerk :-
    class(Class),
    (
        (Class = farmer,
            write('seorang farmer tentu memiliki shovel. mulailah menabur seed dan melihat mereka bertumbuh!\n'),
            farmerArt,
            changeItemCount('corn seed', 3), changeItemCount('shovel', 1), changeItemLevel('shovel', 1));
        (Class = fisherman, 
            write('kamu fisherman, dan kamu takkan lengkap tanpa fishing rod! some salmons won\'t hurt either ;)\n' ),
            fishermanArt,
            changeItemCount('fishing rod', 1), changeItemCount('salmon', 2), changeItemLevel('fishing rod', 1));
        (Class = rancher, 
            write('karena kamu seorang rancher, kamu mendapatkan 3 buah chicken dan 1 buah cow!\n'),
            rancherArt,
            changeItemCount('chicken', 3), changeItemCount('cow')
        )
    ).
farmerArt :-
write('farmer!').
fishermanArt :-
write('fisherman!').
rancherArt :-
write('rancher!').