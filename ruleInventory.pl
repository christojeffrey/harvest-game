% include global
:- include('globalFact.pl').
 :- include('globalRule.pl').
% jadinya inventory itu cuman command, 'benda fisiknya 'dan semuanya disebut item.
% item terdiri dari barang dan equipment  



barangAndEquipmentNameList(['fishing rod', 'shovel', 'tuna', 'salmon', 'catfish', 'corn', 'carrot', 'wheat', 'wool', 'egg', 'milk']).


setInventory :-
    write('set Inventory Command\n'),
    assertz(items([])),
    barangAndEquipmentNameList(ItemNameList),
    initializingItems(ItemNameList),
    write('sudah di initialize\n').

initializingItems(List) :-
    List = [],!.
initializingItems(List) :-
    List = [H|T], items(Prev), append(Prev,[[H,1,0]], New), retract(items(_)), assertz(items(New)), initializingItems(T).



inventory :-
    write('here\'s all of the item that you have!\n'),
    writeAllItems.
 



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
    (ItemLevel = 0 -> write(''); write(ItemLevel), write(' level ')),
    write(ItemName), nl
    ), helperWriteItem(T).
