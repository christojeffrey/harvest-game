% digunakan untuk menampilkan map, dan untuk berpindah.

% include fakta global
:- include('globalFact.pl').

map :- write('ini map').

w :- write('kamu bergerak ke arah utara sebanyak 1 tile').
a :- write('kamu bergerak ke arah barat sebanyak 1 tile').
s :- write('kamu bergerak ke arah selatan sebanyak 1 tile').
d :- write('kamu bergerak ke arah timur sebanyak 1 tile').