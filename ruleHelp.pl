% File ruleHelp.pl
% Contributor : 13520055 & 13520042

% include fakta global
:- include('globalFact.pl').

help :- 
    \+playerState(_), !, 
    write('To open the game, enter the command startGame!').

help :- 
    playerState('startGame'), !, 
    write('1. start : Starts the game').
    write('2. help  : Shows all available commands').

help :- 
    playerState('start'), !, 
    write('1. map    : Shows the map').
    write('2. status : Shows your current status').
    write('3. w      : Moves one step to the north').
    write('4. s      : Moves one step to the south').
    write('5. a      : Moves one step to the west').
    write('6. d      : Moves one step to the east').
    write('8. help   : Shows all available commands').

help :- 
    playerState('house'), !, 
    write('1. sleep      : Advances the day').
    write('2. writeDiary : Adds an entry to your diary').
    write('3. readDiary  : Reads previous diary entries').
    write('4. exitHouse  : Exits the house').
    write('5. help       : Shows all available commands').

help :- 
    playerState('market'), !, 
    write('1. buy        : Buys an item').
    write('2. sell       : Sells an item').
    write('3. exitMarket : Exits the market').
    write('4. help       : Shows all available commands').

help :- 
    playerState('ranch'), !, 
    write('1. help : Shows all available commands').