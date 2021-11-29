% file main hanya berisi include-include dari program lain. ini file yang akan di load di prolog untuk bermain game.

% include fakta global
:- include('globalFact.pl').

% include startGame
:- include('ruleStartGame.pl').

%include help
:- include('ruleHelp.pl').

% include rule yang dapat diakses setelah startGame
:- include('start.pl').

% include rule status
:- include('ruleStatus.pl').
% include rule yang dapat diakses berdasarkan lokasi saat ini
:- include('ruleHouse.pl').
:- include('ruleMarket.pl').
:- include('ruleMap.pl').
:- include('ruleInventory.pl').
:- include('ruleRanch.pl').
:- include('ruleFarm.pl').
:- include('ruleFishing.pl').
%include fakta2 tambahan untuk rule
