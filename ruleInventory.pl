% include global
% :- include('globalFact.pl').
%  :- include('globalRule.pl').
% jadinya inventory itu cuman command, 'benda fisiknya 'dan semuanya disebut item.
% item terdiri dari barang dan equipment  


inventory :-
    playerState('start'),!,
    write('here\'s all of the item that you have!('),
    totalItemCount(Total), write(Total), write('/100)\n'),
    (Total = 0 -> write('kamu tidak punya barang apa-apa\n');
    writeAllItems).

inventory :-
    write('kamu tidak bisa mengakses inventory ketika sedang melakukan eksplorasi,\natau ketika belum memulai game').
% write all item disesuaikan dengan spek
% contoh output
% - 1 Level 1 shovel
% - 3 Carrot
% - 4 Corn
writeAllItems :-
    items(AllItems),
    helperWriteItem(AllItems).


% fungsi atau prosedur perantara dari writeAlItems.
helperWriteItem(ItemList) :-
    ItemList = [],!.
helperWriteItem(ItemList) :-
    ItemList = [H|T], H = [ItemName, ItemCount, ItemLevel], (ItemCount = 0 -> write('');
    write('- '), write(ItemCount), write(' buah '),
    write(ItemName),
    (ItemLevel = 0 -> write(''); write('(level '),write(ItemLevel), write(')')),nl),
    helperWriteItem(T).

throwItem :-
    playerState('start'),!,
    write('item mana yang mau kamu throw?'),nl,
    writeAllItems,
    write('masukkan nama item (tanpa spasi untuk seed)\n> '),
    read(PrevItemName),
    addSpacertoSeed(PrevItemName, ItemName),
    findItem(ItemName, ItemDetail), 
    (ItemDetail = [] -> (
        write('nama item tidak valid'),nl,fail
    );(
        ItemDetail = [_,ItemCount,_]
    )),
    write('kamu akan membuang '), write(ItemName),nl,
    write('jumlah yang kamu miliki adalah '), write(ItemCount), nl,
    write('masukkan jumlah yang ingin kamu buang\n> '),
    read(ItemThrowCount),
    write('ItemThrowCount luar'),
    write(ItemThrowCount),
    ItemThrowCount > ItemCount -> (
        write('jumlah yang akan kamu throw kurang dari yang kamu miliki\n')
    );(
        write('membuang item..'),nl,
        write('ItemThrowCount'),
        write(ItemThrowCount),
        ChangedAmount is -1 * ItemThrowCount,
        write('ChangedAmount'),
        write(ChangedAmount),
        changeItemCount(ItemName, ChangedAmount),
        write('berhasil membuang item!\n')
    ).

throwItem :- write('kamu tidak bisa membuang item disini!'),nl.