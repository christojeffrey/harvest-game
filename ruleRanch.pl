:- include('globalFact.pl').
:- include('globlaRule.pl').

checkAction('chicken').
checkAction('sheep').
checkAction('cow')

cowMaxProduce(0,0).
cowMaxProduce(1,2).
cowMaxProduce(2,3).
cowMaxProduce(3,5).
cowMaxProduce(4,7).

sheepMaxProduce(0,0).
sheepMaxProduce(1,2).
sheepMaxProduce(2,3).
sheepMaxProduce(3,5).
sheepMaxProduce(4,7).

chickenMaxProduce(0,0).
chickenMaxProduce(1,2).
chickenMaxProduce(2,3).
chickenMaxProduce(3,5).
chickenMaxProduce(4,7).

ranch :-
    playerLoc(X1,Y1),
    ranchLoc(X2,Y2),
    ((X1 =:= X2, Y1 =:= Y2, showRanch); ((X1 =\= X2; Y1 =\= Y2), notRanch)).

returnRanchItems(RanchItem, RanchItemQty) :-
    items(AllItems),
    AllItems = [H | T], H = [ItemName, ItemCount, ItemLevel],
    ((RanchItem =\= ItemName, RanchItemQty is 0);(RanchItem =:= ItemName, RanchItemQty is ItemCount)).

showRanch :-
    write('Selamat datang di Ranch!\n'),
    write('Di peternakan anda, anda memiliki:\n'),
    returnRanchItems('Cow', CowQty),
    returnRanchItems('Sheep', SheepQty),
    returnRanchItems('Chicken', ChickenQty),
    write('- '), write(CowQty), write(' sapi\n'),
    write('- '), write(SheepQty), write(' domba\n'),
    write('- '), write(ChickenQty), write(' ayam\n'),
    checkInput('Hewan ternak mana yang ingin anda proses?', Action, checkAction, 'Invalid Input!'),
    doAction(Action, CowQty, SheepQty, ChickenQty).

doAction(Action, CowQty, SheepQty, ChickenQty) :-
    (   Action =:= 'cow', 
        ((\+ cowRanched, (CowQty > 4 -> CowQty is 4),
        cowMaxProduce(CowQty, MaxMilk),
        random(0, MaxMilk, MilkProduce),
        changeItemCount('milk', MilkProduce),
        ((MilkProduce =:= 0, write('Yah sapi kamu belum ada yang menghasilkan susu. Tunggu nanti ya!\n'));
        (MilkProduce > 0, write('Sapi kamu menghasilkan '), write(MilkProduce), write(' botol susu!\n'))), assertz(cowRanched));
        (cowRanched, write('Yah kamu udah menyoba memerah sapi kamu tadi. Coba lagi besok ya\n')).
    );
    (   Action =:= 'sheep',
        ((\+ sheepRanched, (SheepQty > 4 -> SheepQty is 4),
        cowMaxProduce(SheepQty, MaxWool),
        random(0, MaxWool, WoolProduce),
        changeItemCount('wool', WoolProduce),
        ((WoolProduce =:= 0, write('Yah domba kamu belum ada yang menghasilkan wol. Tunggu nanti ya!\n'));
        (WoolProduce > 0, write('Domba kamu menghasilkan '), write(WoolProduce), write(' gulung wol!\n'))), assertz(sheepRanched));
        (sheepRanched, write('Yah kamu udah menyoba memotong bulu domba kamu tadi. Coba lagi besok ya\n'))
    );
    (   Action =:= 'chicken',
        ((\+ chickenRanched, (ChickenQty > 4 -> ChickenQty is 4),
        cowMaxProduce(ChickenQty, MaxEgg),
        random(0, MaxEgg, EggProduce),
        changeItemCount('egg', EggProduce),
        ((EggProduce =:= 0, write('Yah ayam kamu belum ada yang menghasilkan telur. Tunggu nanti ya!\n'));
        (EggProduce > 0, write('Ayam kamu menghasilkan '), write(EggProduce), write(' butir telur!\n'))), assertz(chickenRanched));
        (chickenRanched, write('Yah kamu udah mengambil telur ayam kamu tadi. Coba lagi besok ya\n'))
    ).

notRanch :-
    write('Anda tidak berada di lokasi Ranch saat ini!\n').
    % kembali ke map utama