% jeff
% rule market

% include fakta global
:- include('globalFact.pl').

% fact
% list dulu semua barang yang ada.
% priceList(Barang, Harga).

% rule
market :- 
% cek apakah dia ada di tile market,
% cek apakah dia sudah melakukan start
    retract(playerState(_)),
    assertz(playerState('market')),
    write('welcome to market!'),
    write('what do you want to do?\n'),
    write('1. buy\n'),
    write('2. sell\n'),
    write('3. exitMarket\n').
exitMarket :-
% cek apakah sudah dimarket
    retract(playerState(_)),
    assertz(playerState('start')),
