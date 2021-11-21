% Include file globalFact.pl
:- include('globalFact.pl').
:- include('globalRule.pl').
% Fact untuk Comparison Input Class
checkClass(1).
checkClass(2).
checkClass(3).

% Rules

% Start
start :- 
    reset,
    write('Hai Jeff, yuk jangan meninggoy. Pilih pekerjaanmu!'), nl,
    write('1. Farmer'), nl,
    write('2. Fisherman'), nl,
    write('3. Rancher'), nl,
    checkInput('Pilih Class anda dengan menginput nomornya disini: ', Class, checkClass, 'Invalid Input!'),
    getClass(Class). 



% Ini buat assertz Classnya
getClass(Class) :-
    ((Class == 1, assertz(class(farmer)));
    (Class == 2, assertz(class(fisherman)));
    (Class == 3, assertz(class(rancher)))),
    write('Selamat Jeff! Anda sekarang adalah seorang '),
    class(X), write(X).


% Ini buat reset dan retract Classnya
reset :- retract(class(_)), fail.
reset.