% set semua variabel terjadi di rule ini

% Include file global
:- include('globalFact.pl').
:- include('globalRule.pl').

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
    checkInput('Pilih Class anda dengan menginput nomornya disini', Class, checkClass, 'Invalid Input!'),
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
    % current time 6, kek dari jam 6 pagi. kek sehari ada 24 jam, trus dia suruh bobok kalo udah >= jam 22.00
    assertz(currentTime(6)).
    
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
    retractall(diggedLoc(_,_)),
    generateLand,!.

generateLand:-
    lebarMap(X),
    tinggiMap(Y),
    L is div(X,2),
    T is div(Y,2),
    T1 is T+2,
    L1 is X-3,
    T2 is Y-3,
    YZ is Y-1,
    asserta(questLoc(L,T2)),
    asserta(diggedLoc(1,Y)),
    asserta(diggedLoc(2,Y)),
    asserta(diggedLoc(3,Y)),
    asserta(diggedLoc(4,Y)),
    asserta(diggedLoc(5,Y)),
    asserta(diggedLoc(6,Y)),
    asserta(diggedLoc(1,YZ)),
    asserta(diggedLoc(2,YZ)),
    asserta(diggedLoc(3,YZ)),
    asserta(diggedLoc(4,YZ)),
    asserta(diggedLoc(5,YZ)),
    asserta(diggedLoc(6,YZ)),
    asserta(diggedLoc(6,Y)),
    asserta(diggedLoc(6,YZ)),
    asserta(diggedLoc(7,YZ)),
    asserta(diggedLoc(7,Y)),
    asserta(marketPlaceLoc(L1,T1)),
    asserta(ranchLoc(3,3)),
    asserta(houseLoc(L,T)),
    asserta(playerLoc(L,T)),
    asserta(waterLoc(_,1)),
    asserta(waterLoc(3,9)),
    asserta(waterLoc(1,9)),    
    asserta(waterLoc(2,9)),
    asserta(waterLoc(4,9)),
    asserta(waterLoc(3,10)),
    asserta(waterLoc(4,8)),
    asserta(waterLoc(3,8)),
    asserta(waterLoc(1,8)),
    asserta(waterLoc(2,8)), 
    asserta(waterLoc(3,7)),
    asserta(waterLoc(2,7)),
    asserta(waterLoc(2,10)),!.

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
    write('\ngunakan command help untuk mengetahui semua hal yang bisa kamu lakukan!\ncoba ketikkan map.\n').


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
            changeItemCount('chicken', 3), changeItemCount('cow', 1)    
        )
    ).
farmerArt :-
write('         wWWWw               wWWWw'),nl,
write('   vVVVv (___) wWWWw         (___)  vVVVv'),nl,
write('   (___)  ~Y~  (___)  vVVVv   ~Y~   (___)'),nl,
write('    ~Y~   \\|    ~Y~   (___)    |/    ~Y~'),nl,
write('    \\|   \\ |/   \\| /  \\~Y~/   \\|    \\ |/'),nl,
write('   \\\\|// \\\\|// \\\\|/// \\\\|//  \\\\|// \\\\\\|///'),nl,
write('jgs^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'),nl.
fishermanArt :-
write('       .'),nl,
write('      ":"'),nl,
write('    ___:____     |"\\/"|'),nl,
write('  ,\'        `.    \\  /'),nl,
write('  |  O        \\___/  |'),nl,
write('~^~^~^~^~^~^~^~^~^~^~^~^~'),nl.
rancherArt :-
    write('                ,/         \\,'),nl,
    write('               ((__,-"""-,__))'),nl,
    write('                `--)~   ~(--`'),nl,
    write('               .-\'(       )`-,'),nl,
    write('               `~~`d\\   /b`~~`'),nl,
    write('                   |     |'),nl,
    write('                   (6___6)'),nl,
    write('                    `---`'),nl.