% rule market


% fact
% list dulu semua barang yang ada.
% priceList(Barang, Harga).
priceList('corn seed', 50).
priceList('carrot seed', 50).
priceList('wheat seed', 50).

priceList('corn', 100).
priceList('carrot', 200).
priceList('wheat', 300).

priceList('tuna', 400).
priceList('salmon', 500).
priceList('catfish', 600).

priceList('wool', 700).
priceList('egg', 800).
priceList('milk', 900).

priceList('chicken', 1000).
priceList('sleep', 1200).
priceList('cow', 1400).
% level 1 seharga 3000, level 2 seharga 4000, level 3 seharga 5000
priceList('fishing rod', 2000).
priceList('shovel', 2000).

equipmentList('shovel').
equipmentList('fishing rod').
% command sementara selagi blom ada startGame
% rule
market :- 
% cek apakah dia ada di tile market,
% cek apakah dia sudah melakukan start
    playerState('start'),!,
    isCommandAllowed,
    retract(playerState(_)),
    assertz(playerState('market')),
    write('welcome to market!'),
    write('what do you want to do?\n'),
    write('1. buy\n'),
    write('2. sell\n'),
    write('3. exitMarket\n'),
    write('pilih dengan command buy sell atau exitMarket.\n').
market :-
    write('kamu tidak bisa masuk ke market, pergilah dulu ke tile market\n').


% cek dulu apakah inventory penuh
buy :-
    totalItemCount(TotalItemCount),
    TotalItemCount \= 100,
    playerState('market'),!,
    write('kamu memilih buy\n'),
    write('uang kamu saat ini: '), gold(Gold), write(Gold), nl,
    write('berikut pilihan benda yang dapat kamu beli!\n'),
    forall(
        priceList(Item,Price),(
            write('- '), write(Item), 
            (equipmentList(Item) -> (
                findItem(Item, ItemDetail), ItemDetail = [_,_,ItemLevel],
                write(' '),
                NewLevel is ItemLevel + 1 , write('level '), write(NewLevel),
                write(', '), NewPrice is Price + (NewLevel * 1000), 
                write(NewPrice), write(' gold'),nl
            );(
                write(', '), write(Price), write(' gold'),nl
            )
            )
        )
    ),
    write('masukkan nama item yang ingin kamu beli\n> '),
    read(ItemToBuy),
    proccesBuy(ItemToBuy),
    goalState,
    addTimeByX(2).

buy :-
    write('kamu tidak bisa melakukan buy.\n inventory kamu sudah penuh atau kamu tidak ada di market. ke market.\nJual inventorymu atau gunakan inventorymu, atau pergilah ke market.\n').

% pembantu dari rule buy
proccesBuy(ItemName) :-
    priceList(ItemName, ItemPrice), !,
    write('Masukkan jumlah item yang ingin kamu beli \n> '),
    read(ItemBuyCount),
    totalItemCount(TotalItemCount),
    % cek apakah jumlahnya melebihi batas maksimum
    ((TotalItemCount + ItemBuyCount > 100) -> (
        write('Kamu tidak bisa membeli sebanyak itu, akan melebihi jumlah kapasitas maksimum\n')
    );( % kalo gk melebihi, cek apakah uang mencukupi, kalo mencukupi lakukan transaksi.
        gold(Gold), write('gold kamu awalnya sejumlah '), write(Gold), nl,
        write('harga barang yang kamu beli adalah '),TotalPrice is  ItemBuyCount * ItemPrice, 
        write(TotalPrice), nl,
        ((Gold < TotalPrice) -> ( % kalo uang gk cukup
            write('uang kamu tidak mencukupi :(\n')
        );( % kalo uang cukup
            write('membeli '), write(ItemBuyCount), write(' buah '), write(ItemName),nl,
            changeItemCount(ItemName, ItemBuyCount),
            NewGold is (Gold - (ItemBuyCount * ItemPrice)),
            retract(gold(_)),
            assertz(gold(NewGold))
        ))
    )).

proccesBuy(_) :-
    write('nama item yang kamu masukkan tidak valid\n').


sell :-
    playerState('market'),!,
    totalItemCount(Total),
    (Total == 0 ->(
        write('kamu tidak punya barang yang bisa dijual\n')
    );(
        write('berikut barang-barang yang bisa kamu jual\n'),
        items(AllItems),
        helperShowAllSellItem(AllItems),
        write('masukkan nama barang yang ingin kamu jual\n> '),
        read(ItemNameToSell),
        processSell(ItemNameToSell)
    )),
    addTimeByX(2).
sell :-
    write('kamu tidak sedang berada di market.\n').

% fungsi pembantu helper item
helperShowAllSellItem(ItemList) :-
    ItemList = [],!.
helperShowAllSellItem(ItemList) :-
    ItemList = [H|T], H = [ItemName, ItemCount, ItemLevel],
    (ItemCount = 0 -> 
        true
        ;(
            write('- '), write(ItemCount), write(' buah '),
            write(ItemName),
            priceList(ItemName, ItemPrice), 
            (ItemLevel = 0 -> 
                SellPrice is 0.8 * ItemPrice; 
                write('(level '),write(ItemLevel), write(')'), 
                SellPrice is 0.8 * (ItemPrice + (ItemLevel * 1000))
            ),
            write( ', seharga '), write(SellPrice),
            nl
        )
    ),
    helperShowAllSellItem(T).

processSell(ItemName) :-
    priceList(ItemName, ItemPrice), !,
    write('Masukkan jumlah item yang ingin kamu jual \n> '),
    read(ItemSellCount),
    findItem(ItemName, ItemDetails), ItemDetails = [_,ItemCount,ItemLevel],
    (ItemSellCount > ItemCount ->(
        write('jumlah yang ingin kamu jual melebihi jumlah yang kamu miliki\n')
    );(
        % berhasil menjual, mengurangi jumlah item di inventory dan mengupdate uang
        ChangedAmount is -1* ItemSellCount,
        changeItemCount(ItemName, ChangedAmount),
        gold(Gold),
        (ItemLevel = 0 -> 
                SellPrice is 0.8 * ItemPrice; 
                SellPrice is 0.8 * (ItemPrice + (ItemLevel * 1000))
        ),
        NewGold is Gold + (SellPrice * ItemSellCount),
        write('penjualan berhasil!\n'),
        write('uangmu bertambah menjadi : '), write(NewGold), write('!'), nl,
        retract(gold(_)),
        assertz(gold(NewGold))
    )).

processSell(_,_) :-
        write('nama item yang kamu masukkan tidak valid\n').


exitMarket :-
% cek apakah sudah dimarket
    playerState('market'),!,
    retract(playerState(_)),
    assertz(playerState('start')),
    write('berhasil keluar dari market\n').


exitMarket :- 
write('kamu tidak sedang berada di dalam market\n').