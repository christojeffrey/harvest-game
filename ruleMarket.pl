% jeff
% rule market

% include fakta global
:- include('globalFact.pl').

% fact
% list dulu semua barang yang ada.
% priceList(Barang, Harga).
priceList('corn', 100).
priceList('carrot', 200).
priceList('wheat', 300).

priceList('tuna', 400).
priceList('salmon', 500).
priceList('catfish', 600).

priceList('wool', 700).
priceList('egg', 800).
priceList('milk', 900).

% command sementara selagi blom ada startGame
setMarket :-
    assertz(money(1000)),
    assertz(playerState('start')).
% rule
market :- 
% cek apakah dia ada di tile market,
% cek apakah dia sudah melakukan start
    playerState('start'),!,
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

buy :-
    playerState('market'),!,
    write('kamu memilih buy\n'),
    write('uang kamu saat ini: '), money(Gold), write(Gold), nl,
    write('berikut pilihan benda yang dapat kamu beli!\n'),
    forall(priceList(Item,Price),(write('- '), write(Item), write(', '), write(Price), write(' gold'),nl)),
    write('masukkan nama item yang ingin kamu beli\n>'),
    read(ItemToBuy),
    write('kamu ingin membeli '), write(ItemToBuy).

buy :-
    write('kamu tidak bisa melakukan buy. pergilah ke market').

exitMarket :-
% cek apakah sudah dimarket
    playerState('market'),!,
    retract(playerState(_)),
    assertz(playerState('start')),
    write('berhasil keluar dari market\n').


exitMarket :- 
write('kamu tidak sedang berada di dalam market\n').