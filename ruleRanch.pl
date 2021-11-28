checkAction('chicken').
checkAction('sheep').
checkAction('cow').

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

showRanch :-
    write('Selamat datang di Ranch!\n'),
    write('Di peternakan anda, anda memiliki:\n'),
    findItem('cow', CowCountLevel),
    findItem('sheep', SheepCountLevel),
    findItem('chicken', ChickenCountLevel),
    nth0(1, CowCountLevel, CowQty),
    nth0(1, SheepCountLevel, SheepQty),
    nth0(1, ChickenCountLevel, ChickenQty),
    write('- '), write(CowQty), write(' sapi\n'),
    write('- '), write(SheepQty), write(' domba\n'),
    write('- '), write(ChickenQty), write(' ayam\n'),
    checkInput('Hewan ternak mana yang ingin anda proses?', Action, checkAction, 'Invalid Input!'),
    doAction(Action, CowQty, SheepQty, ChickenQty).

doAction(Action, CowQty, SheepQty, ChickenQty) :-
    (   Action = 'cow', 
        ((CowQty > 0, (
            (
                \+ cowRanched, 
                ((CowQty < 5, cowMaxProduce(CowQty, MaxMilk),
                random(0, MaxMilk, MilkProduce),
                changeItemCount('milk', MilkProduce),
                (
                    (
                        MilkProduce =:= 0, write('Yah sapi kamu belum ada yang menghasilkan susu. Tunggu nanti ya!\n')
                    );(
                        MilkProduce > 0, write('Sapi kamu menghasilkan '), write(MilkProduce), write(' botol susu!\n')
                    )
                ),
                assertz(cowRanched), addTimeByX(1),
                AddedRanchEXP is 10 * MilkProduce,
                addRanchingEXPByX(AddedRanchEXP),
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n'));
                (CowQty >= 5, cowMaxProduce(4, MaxMilk),
                ExtraCow is CowQty - 4,
                MaxMilk is MaxMilk + ExtraCow,
                random(0, MaxMilk, MilkProduce),
                changeItemCount('milk', MilkProduce),
                (
                    (
                        MilkProduce =:= 0, write('Yah sapi kamu belum ada yang menghasilkan susu. Tunggu nanti ya!\n')
                    );(
                        MilkProduce > 0, write('Sapi kamu menghasilkan '), write(MilkProduce), write(' botol susu!\n')
                    )
                ),
                assertz(cowRanched), addTimeByX(1),
                AddedRanchEXP is 10 * MilkProduce,
                addRanchingEXPByX(AddedRanchEXP),
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n')
            ))
            );(
                cowRanched, write('Yah kamu udah mengambil susu sapi kamu tadi. Coba lagi besok ya\n')
            )
        ));
        (CowQty =< 0,
        write('Kamu tidak memiliki sapi. Silahkan beli sapi di market ya!\n')
        ))
    );
    (   Action = 'sheep',
        ((SheepQty > 0, (
            (
                \+ sheepRanched, 
                ((SheepQty < 5, chickenMaxProduce(SheepQty, MaxWool),
                random(0, MaxWool, WoolProduce),
                changeItemCount('wool', WoolProduce),
                (
                    (
                        WoolProduce =:= 0, write('Yah domba kamu belum ada yang menghasilkan wol. Tunggu nanti ya!\n')
                    );(
                        WoolProduce > 0, write('Domba kamu menghasilkan '), write(WoolProduce), write(' gulung wol!\n')
                    )
                ),
                assertz(sheepRanched), addTimeByX(1),
                AddedRanchEXP is 5 * WoolProduce,
                addRanchingEXPByX(AddedRanchEXP),
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n'));
                (SheepQty >= 5, sheepMaxProduce(4, MaxWool),
                ExtraSheep is SheepQty - 4,
                MaxWool is ExtraSheep + MaxWool,
                random(0, MaxWool, WoolProduce),
                changeItemCount('wool', WoolProduce),
                (
                    (
                        WoolProduce =:= 0, write('Yah domba kamu belum ada yang menghasilkan wol. Tunggu nanti ya!\n')
                    );(
                        WoolProduce > 0, write('Domba kamu menghasilkan '), write(WoolProduce), write(' gulung wol!\n')
                    )
                ),
                assertz(sheepRanched), addTimeByX(1),
                AddedRanchEXP is 5 * WoolProduce,
                addRanchingEXPByX(AddedRanchEXP),
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n')))
            );(
                sheepRanched, write('Yah kamu udah mengambil wol domba kamu tadi. Coba lagi besok ya\n')
            )
        ));
        (SheepQty =< 0,
        write('Kamu tidak memiliki domba. Silahkan beli domba di market ya!\n')
        ))
    );
    (   Action = 'chicken',
        ((ChickenQty > 0, (
            (
                \+ chickenRanched, 
                ((ChickenQty < 5, chickenMaxProduce(ChickenQty, MaxEgg),
                random(0, MaxEgg, EggProduce),
                changeItemCount('egg', EggProduce),
                (
                    (
                        EggProduce =:= 0, write('Yah ayam kamu belum ada yang menghasilkan telur. Tunggu nanti ya!\n')
                    );(
                        EggProduce > 0, write('Ayam kamu menghasilkan '), write(EggProduce), write(' butir telur!\n')
                    )
                ),
                assertz(chickenRanched), addTimeByX(1),
                AddedRanchEXP is 7 * EggProduce,
                addRanchingEXPByX(AddedRanchEXP),
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n'));
                (ChickenQty >= 5, chickenMaxProduce(4, MaxEgg),
                ExtraChicken is ChickenQty - 4,
                MaxEgg is MaxEgg + ExtraChicken,
                random(0, MaxEgg, EggProduce),
                changeItemCount('egg', EggProduce),
                (
                    (
                        EggProduce =:= 0, write('Yah ayam kamu belum ada yang menghasilkan telur. Tunggu nanti ya!\n')
                    );(
                        EggProduce > 0, write('Ayam kamu menghasilkan '), write(EggProduce), write(' butir telur!\n')
                    )
                ),
                assertz(chickenRanched), addTimeByX(1),
                AddedRanchEXP is 7 * EggProduce,
                addRanchingEXPByX(AddedRanchEXP),
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n')))
            );(
                chickenRanched, write('Yah kamu udah mengambil telur ayam kamu tadi. Coba lagi besok ya\n')
            )
        ));
        (ChickenQty =< 0,
        write('Kamu tidak memiliki ayam. Silahkan beli ayam di market ya!\n')
        ))
    ).

notRanch :-
    write('Anda tidak berada di lokasi Ranch saat ini!\n').
    % kembali ke map utama