% file main hanya berisi include-include dari program lain. ini file yang akan di load di prolog untuk bermain game.

% include fakta global
:- include('globalFact.pl').

% include startGame
:- include('ruleStartGame.pl').

%i include rule yang dapat diakses setelah startGame
:- include('start.pl').

% include rule yang dapat diakses berdasarkan lokasi saat ini

%include fakta2 tambahan untuk rule
