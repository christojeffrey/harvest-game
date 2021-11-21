% untuk menyimpan rule yang relaitf umum dan bisa digunakan untuk lebih dari satu command
:- include('globalFact.pl').

% rule untuk input

% dibuat sama gede

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


%rule untuk time

% menambahkan time sebanyak X(yaitu input)
addTimeByX(X) :- 
    retract(currentTime(Timenow)), 
    Timenew is Timenow + X,  
    assertz(currentTime(Timenew)).


% melakukan pengecekan apakah suatu perintah dapat dilakukan, berdasarkan time saat ini.
% jika suatu perintah diperbolehkan(artinya 'hari belum habis'), maka command akan diteruskan.
% jika suatu perintah tidak diperbolehkan, maka akan memberikan print keterangan untuk menyuruh player untuk tidur. lalu dan diakhiri dengan fail agar command tidak bisa diteruskan.

% contoh penggunaan
% ruleFly :-
%     isCommandAllowed,
%     addTimeByX(2),
%     command2 yang berhubungan dengan farm.

% jangan pake isCommandAllowed di move w a s d ya, nti dia gabisa pulang :v

% untuk saat ini, batas time dalam satu hari adalah 20
isCommandAllowed :-
    currentTime(X), X >= 20, write('harimu sudah habis! kerumah trus bobok yah\n'), fail.
