takeQuest('ambil').
takeQuest('tolak').

offerQuest('mau').
offerQuest('tidak').

generateThreeRandomIndexes(IdxFirst, IdxSecond, IdxThird) :-
    random(1, 4, IdxFirst),
    random(4, 7, IdxSecond),
    random(7, 10, IdxThird).

generateThreeRandomQty(FirstQty, SecondQty, ThirdQty) :-
    random(1, 8, FirstQty),
    random(1, 8, SecondQty),
    random(1, 8, ThirdQty).

generateQuestItems(IdxFirst, IdxSecond, IdxThird, FirstItem, SecondItem, ThirdItem) :-
    questable_items(List),
    nth(IdxFirst, List, FirstItem),
    nth(IdxSecond, List, SecondItem),
    nth(IdxThird, List, ThirdItem).

generateRewardGoldEXP(IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold3, RewardEXP3) :-
    RewardGold is 0, RewardEXP is 0,
    ((IdxFirst = 1, RewardGold1 is RewardGold + (50 * FirstQty), RewardEXP1 is RewardEXP + (5 * FirstQty)); 
    (IdxFirst = 2, RewardGold1 is RewardGold + (100 * FirstQty), RewardEXP1 is RewardEXP + (7 * FirstQty)); 
    (IdxFirst = 3, RewardGold1 is RewardGold + (150 * FirstQty), RewardEXP1 is RewardEXP + (10 * FirstQty))),
    ((IdxSecond = 4, RewardGold2 is RewardGold1 + (10 * FirstQty), RewardEXP2 is RewardEXP1 + (2 * SecondQty));
    (IdxSecond = 5, RewardGold2 is RewardGold1 + (20 * FirstQty), RewardEXP2 is RewardEXP1 + (3 * SecondQty));
    (IdxSecond = 6, RewardGold2 is RewardGold1 + (25 * FirstQty), RewardEXP2 is RewardEXP1 + (5 * SecondQty))),
    ((IdxThird = 7, RewardGold3 is RewardGold2 + (30 * FirstQty), RewardEXP3 is RewardEXP2 + (5 * ThirdQty));
    (IdxThird = 8, RewardGold3 is RewardGold2 + (20 * FirstQty), RewardEXP3 is RewardEXP2 + (4 * ThirdQty));
    (IdxThird = 9, RewardGold3 is RewardGold2 + (50 * FirstQty), RewardEXP3 is RewardEXP2 + (8 * ThirdQty))).

checkQuest :- quest(_,_,_,_,_,_,_,_).

quest :-
    playerLoc(PX,PY),
    questLoc(PX,PY),!,
    ((checkQuest, ongoingQuest);
    (\+ checkQuest, 
    write('Saat ini kamu tidak memiliki quest.\n'),
    checkInput('Apakah kamu ingin mengambil quest baru? Ketik "mau." bila iya atau "tidak." bila tidak', Offer, offerQuest, 'Input tidak dikenali, silahkan coba ulang'),
    checkOffer(Offer))).

quest :-
    write('kamu tidak bisa menjalankan rule quest!'),nl,
    write('jalankan game dan pergilah ke tile quest!'),nl.

checkOffer(Offer) :-
    ((Offer == 'mau', 
    generateQuest);
    (Quest == 'tidak',
    write('Kamu menolak tawaran quest ini. Silahkan ketik "quest."" lagi jika kamu berubah pikiran.\n')
    )).

ongoingQuest :-
    quest(IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP),
    generateQuestItems(IdxFirst, IdxSecond, IdxThird, FirstItem, SecondItem, ThirdItem),
    write('Saat ini kamu memiliki sebuah quest!'), nl,
    write('Kamu harus mendapatkan :'), nl,
    write('- '), write(FirstQty), write(' '), write(FirstItem), nl,
    write('- '), write(SecondQty), write(' '), write(SecondItem), nl,
    write('- '), write(ThirdQty), write(' '), write(ThirdItem), nl,
    write('Kamu akan dihadiahkan dengan '), write(RewardGold), write(' Gold dan '), write(RewardEXP), write(' EXP!'), nl,
    findItem(FirstItem, FirstList),
    findItem(SecondItem, SecondList),
    findItem(ThirdItem, ThirdList),
    nth(2, FirstList, FirstQtyPlayer),
    nth(2, SecondList, SecondQtyPlayer),
    nth(2, ThirdList, ThirdQtyPlayer),
    write('Saat ini kamu memiliki :'), nl,
    write('- '), write(FirstQty), write(' '), write(FirstItem), nl,
    write('- '), write(SecondQty), write(' '), write(SecondItem), nl,
    write('- '), write(ThirdQty), write(' '), write(ThirdItem), nl,
    write('Jika kamu sudah memiliki jumlah item yang cukup,\n'),
    write('Kamu dapat mengumpulkan quest dengan mengetik "submitQuest.').

generateQuest :-
    generateThreeRandomIndexes(IdxFirst, IdxSecond, IdxThird),
    generateQuestItems(IdxFirst, IdxSecond, IdxThird, FirstItem, SecondItem, ThirdItem),
    generateThreeRandomQty(FirstQty, SecondQty, ThirdQty),
    generateRewardGoldEXP(IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP),
    write('Kamu punya quest baru!'), nl,
    nl,
    write('Kamu perlu mengumpulkan:'), nl,
    write('- '), write(FirstQty), write(' '), write(FirstItem), nl,
    write('- '), write(SecondQty), write(' '), write(SecondItem), nl,
    write('- '), write(ThirdQty), write(' '), write(ThirdItem), nl,
    write('Bila kamu berhasil, kamu akan mendapatkan '), write(RewardGold), write(' Gold dan '), write(RewardEXP), write(' EXP!'), nl,
    checkInput('Ambil quest ini? Ketik "ambil." bila iya atau "tolak." bila tidak', Quest, takeQuest, 'Input tidak sesuai, silahkan coba lagi!'),
    questAction(Quest, IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP).

questAction(Quest, IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP) :-
    ((Quest == 'ambil', 
    assertz(quest(IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP)),
    write('Kamu telah mengambil quest ini. Selamat berjuang!\n')
    );(Quest == 'tolak',
    write('Kamu menolak quest ini. Silahkan minta quest lagi jika kamu masih ingin mendapatkan sebuah quest.\n')
    )).

checkItemQtys(FirstItem, SecondItem, ThirdItem, FirstQty, SecondQty, ThirdQty) :-
    findItem(FirstItem, FirstItemList),
    findItem(SecondItem, SecondItemList),
    findItem(ThirdItem, ThirdItemList),
    nth(2, FirstItemList, FirstQtyPlayer),
    nth(2, SecondItemList, SecondQtyPlayer),
    nth(2, ThirdItemList, ThirdQtyPlayer),
    FirstQtyPlayer > FirstQty,
    SecondQtyPlayer > SecondQty,
    ThirdQtyPlayer > ThirdQty.

submitQuest :-
    retract(quest(IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP)),
    generateQuestItems(IdxFirst, IdxSecond, IdxThird, FirstItem, SecondItem, ThirdItem),
    ((\+ checkItemQtys(FirstItem, SecondItem, ThirdItem, FirstQty, SecondQty, ThirdQty), 
    assertz(quest(IdxFirst, IdxSecond, IdxThird, FirstQty, SecondQty, ThirdQty, RewardGold, RewardEXP)),
    write('Anda belum mencapai jumlah barang yang dibutuhkan untuk memenuhi quest ini!'), nl,
    write('Silahkan coba lagi nanti!\n'));
    (checkItemQtys(FirstItem, SecondItem, ThirdItem, FirstQty, SecondQty, ThirdQty),
    SubtractFirstQty is (-1) * FirstQty,
    SubtractSecondQty is (-1) * SecondQty,
    SubtractThirdQty is (-1) * ThirdQty,
    changeItemCount(FirstItem, SubtractFirstQty),
    changeItemCount(SecondItem, SubtractSecondQty),
    changeItemCount(ThirdItem, SubtractThirdQty),
    addMainEXPByX(RewardEXP),
    addGoldbyX(RewardGold),
    write('Kamu telah berhasil menyelesaikan quest ini!'), nl,
    write('Kamu mendapatkan '), write(RewardGold), write(' Gold dan '), write(RewardEXP), write(' EXP!')
    )).