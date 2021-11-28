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
