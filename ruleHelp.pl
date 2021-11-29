% File ruleHelp.pl
% Contributor : 13520055 & 13520042

% Include global facts
:- include('globalFact.pl').

% For debugging purposes
% playerState('market').

help :- 
    \+playerState(_), !, 
    write('To open the game, enter the command startGame!').

help :- 
    playerState('startGame'), !, 
    write('1. start     : Starts the game'), nl,
    write('2. help      : Shows all available commands'),nl,
    write('3. exitGame  : exit the game').
    

help :- 
    playerState('start'), !, 
    write('1.  map     : Shows the map'), nl,
    write('2.  status  : Shows your current status'), nl,
    write('3.  w       : Moves one step to the north'), nl,
    write('4.  s       : Moves one step to the south'), nl,
    write('5.  a       : Moves one step to the west'), nl,
    write('6.  d       : Moves one step to the east'), nl,
    write('7.  dig     : (When on a farming tile) Digs on a tillable tile'), nl,
    write('8.  plant   : (When on a farming tile) Plants a seed on a tilled tile'), nl,
    write('9.  harvest : (When on a farming tile) Harvests crop from a planted tile'), nl,
    write('10. fish    : (When near a body of water) Starts fishing'), nl,
    write('11. ranch   : (When on a ranching tile) Starts ranching'), nl,
    write('12. quest   : (When on a quest tile) Starts a quest'), nl,
    write('13. help    : Shows all available commands').

help :- 
    playerState('house'), !, 
    write('1. sleep      : Advances the day'), nl,
    write('2. writeDiary : Adds an entry to your diary'), nl,
    write('3. readDiary  : Reads previous diary entries'), nl,
    write('4. exitHouse  : Exits the house'), nl,
    write('5. help       : Shows all available commands').

help :- 
    playerState('market'), !, 
    write('1. buy        : Buys an item'), nl,
    write('2. sell       : Sells an item'), nl,
    write('3. exitMarket : Exits the market'), nl,
    write('4. help       : Shows all available commands').
