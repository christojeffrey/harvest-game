% Include file globalFact.pl
:- include('globalFact.pl').

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

% Untuk mengecek input, bisa dipake buat input apa aja tbh
% Question itu isinya string buat minta query
% Input itu isinya nama variabel yang bakal nyimpen inputnya
% Comparison itu isinya fact/rule buat ngecek Input valid atau engga
% ErrorMessage itu ditampilin kalau Input tidak sesuai Comparison
checkInput(Question, Input, Comparison, ErrorMessage) :-
    repeat,
        format('~w:~n', [Question]),
        read(Input),
        (   call(Comparison, Input)
        ->  true, !
        ;   format('ERROR: ~w:~n', [ErrorMessage]),
            fail
        ).

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