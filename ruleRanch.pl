checkAction('ayam').
checkAction('domba').
checkAction('sapi').

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

% rule untuk waktu ranching
bonusEXPRanchClass(BonusEXP) :-
    class(Class), 
    ((Class = rancher, BonusEXP is 10);
    (\+ (Class = rancher), BonusEXP is 0)).

refreshCowCooldown :-
    retract(cowCooldown(X)),
    levelRanching(Level),
    ((Level == 1 -> assertz(cowCooldown(12)));
    (Level == 2 -> assertz(cowCooldown(10)));
    (Level == 3 -> assertz(cowCooldown(8)));
    (Level == 4 -> assertz(cowCooldown(6)));
    (Level == 5 -> assertz(cowCooldown(5)))).

refreshChickenCooldown :-
    retract(chickenCooldown(X)),
    levelRanching(Level),
    ((Level == 1 -> assertz(chickenCooldown(7)));
    (Level == 2 -> assertz(chickenCooldown(6)));
    (Level == 3 -> assertz(chickenCooldown(5)));
    (Level == 4 -> assertz(chickenCooldown(4)));
    (Level == 5 -> assertz(chickenCooldown(3)))).

refreshSheepCooldown :-
    retract(sheepCooldown(X)),
    levelRanching(Level),
    ((Level == 1 -> assertz(sheepCooldown(10)));
    (Level == 2 -> assertz(sheepCooldown(9)));
    (Level == 3 -> assertz(sheepCooldown(7)));
    (Level == 4 -> assertz(sheepCooldown(6)));
    (Level == 5 -> assertz(sheepCooldown(5)))).

ranch :-
    playerLoc(X1,Y1),
    ranchLoc(X2,Y2),
    ((X1 =:= X2, Y1 =:= Y2, showRanch); ((X1 =\= X2; Y1 =\= Y2), notRanch)).

showRanch :-
    isCommandAllowed,
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
    bonusEXPRanchClass(BonusEXP),
    totalItemCount(TotalCount),
    (   Action = 'sapi', cowCooldown(CowTime),
        ((CowQty > 0, (
            (
                CowTime = 0, 
                ((CowQty < 5, cowMaxProduce(CowQty, MaxMilk),
                random(0, MaxMilk, MilkProduce),
                (
                    (
                        MilkProduce = 0, write('Yah sapi kamu belum ada yang menghasilkan susu. Tunggu nanti ya!\n')
                    );(
                        MilkProduce > 0, write('Sapi kamu menghasilkan '), write(MilkProduce), write(' botol susu!\n'), changeItemCount('milk', MilkProduce)
                    )
                ),
                refreshCowCooldown, addTimeByX(3),
                AddedRanchEXP is 15 * MilkProduce + BonusEXP,
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                addRanchingEXPByX(AddedRanchEXP), nl,
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n'));
                (CowQty >= 5, cowMaxProduce(4, MaxMilk),
                ExtraCow is CowQty - 4,
                MaxMilk is MaxMilk + ExtraCow,
                random(0, MaxMilk, MilkProduce),
                (
                    (
                        MilkProduce = 0, write('Yah sapi kamu belum ada yang menghasilkan susu. Tunggu nanti ya!\n')
                    );(
                        MilkProduce > 0, write('Sapi kamu menghasilkan '), write(MilkProduce), write(' botol susu!\n'), changeItemCount('milk', MilkProduce)
                    )
                ),
                refreshCowCooldown, addTimeByX(3),
                AddedRanchEXP is 15 * MilkProduce + BonusEXP,
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                addRanchingEXPByX(AddedRanchEXP), nl,
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n')
            ))
            )
        ));
        (CowQty =< 0,
        write('Kamu tidak memiliki sapi. Silahkan beli sapi di market ya!\n')
        );
        (CowQty > 0, CowTime > 0,
        write('Sapi kamu baru diperah kemarin. Silahkan tunggu '), write(CowTime), write(' hari')
        )
        )
    );
    (   Action = 'domba', sheepCooldown(SheepTime),
        ((SheepQty > 0, (
            (
                SheepTime = 0, 
                ((SheepQty < 5, sheepMaxProduce(SheepQty, MaxWool),
                random(0, MaxWool, WoolProduce),
                (
                    (
                        WoolProduce = 0, write('Yah domba kamu belum ada yang menghasilkan wol. Tunggu nanti ya!\n')
                    );(
                        WoolProduce > 0, write('Domba kamu menghasilkan '), write(WoolProduce), write(' gulung wol!\n'), changeItemCount('wool', WoolProduce)
                    )
                ),
                refreshSheepCooldown, addTimeByX(2),
                AddedRanchEXP is 12 * WoolProduce + BonusEXP,
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                addRanchingEXPByX(AddedRanchEXP), nl,
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n'));
                (SheepQty >= 5, sheepMaxProduce(4, MaxWool),
                ExtraSheep is SheepQty - 4,
                MaxWool is MaxWool + ExtraSheep,
                random(0, MaxWool, WoolProduce),
                (
                    (
                        WoolProduce = 0, write('Yah domba kamu belum ada yang menghasilkan wol. Tunggu nanti ya!\n')
                    );(
                        WoolProduce > 0, write('Domba kamu menghasilkan '), write(WoolProduce), write(' gulung wol!\n'), changeItemCount('wool', WoolProduce)
                    )
                ),
                refreshSheepCooldown, addTimeByX(2),
                AddedRanchEXP is 12 * WoolProduce + BonusEXP,
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                addRanchingEXPByX(AddedRanchEXP), nl,
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n')
            ))
            )
        ));
        (SheepQty =< 0,
        write('Kamu tidak memiliki domba. Silahkan beli domba di market ya!\n')
        );
        (SheepQty > 0, SheepTime > 0,
        write('Domba kamu baru dicukur kemarin. Silahkan tunggu '), write(SheepTime), write(' hari')
        )
        )
    );
    (   Action = 'ayam', chickenCooldown(ChickenTime),
        ((ChickenQty > 0, (
            (
                ChickenTime = 0, 
                ((ChickenQty < 5, chickenMaxProduce(ChickenQty, MaxEgg),
                random(0, MaxEgg, EggProduce),
                (
                    (
                        EggProduce = 0, write('Yah ayam kamu belum ada yang menghasilkan telur. Tunggu nanti ya!\n')
                    );(
                        EggProduce > 0, write('Ayam kamu menghasilkan '), write(EggProduce), write(' telur!\n'), changeItemCount('egg', EggProduce)
                    )
                ),
                refreshChickenCooldown, addTimeByX(2),
                AddedRanchEXP is 10 * EggProduce + BonusEXP,
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                addRanchingEXPByX(AddedRanchEXP), nl,
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n'));
                (ChickenQty >= 5, chickenMaxProduce(4, MaxEgg),
                ExtraChicken is ChickenQty - 4,
                MaxEgg is MaxEgg + ExtraChicken,
                random(0, MaxEgg, EggProduce),
                (
                    (
                        EggProduce = 0, write('Yah sapi kamu belum ada yang menghasilkan susu. Tunggu nanti ya!\n')
                    );(
                        EggProduce > 0, write('Sapi kamu menghasilkan '), write(EggProduce), write(' botol susu!\n'), changeItemCount('egg', EggProduce)
                    )
                ),
                refreshChickenCooldown, addTimeByX(2),
                AddedRanchEXP is 15 * EggProduce + BonusEXP,
                write('Kamu mendapatkan '), write(AddedRanchEXP), write(' Ranch EXP!\n'),
                addRanchingEXPByX(AddedRanchEXP), nl,
                expRanching(TotalEXPRanch),
                write('Total Ranch EXP kamu adalah '), write(TotalEXPRanch), write(' Ranch EXP!\n')
            ))
            )
        ));
        (ChickenQty =< 0,
        write('Kamu tidak memiliki ayam. Silahkan beli ayam di market ya!\n')
        );
        (ChickenQty > 0, ChickenTime > 0,
        write('Ayam kamu baru bertelur kemarin. Silahkan tunggu '), write(ChickenTime), write(' hari')
        )
        )
    ).

notRanch :-
    write('Anda tidak berada di lokasi Ranch saat ini!\n').