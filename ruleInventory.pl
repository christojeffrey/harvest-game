% include fakta global
:- include('globalFact.pl').

:- dynamic(inventoryCount/1).

initInventory :- 
    asserta(inventoryCount(0)).

% Display inventory
% inventory :- !.

% Add item to inventory
addItem(_, Count, _) :-
    inventoryCount(CurrCount),
    CurrCount + Count > 100, fail.

addItem(Item, 1, Level) :-
    \+inventoryList(Item, _, _),
    asserta(inventoryList(Item, 1, Level)),
    retract(inventoryCount(Count)),
    asserta(inventoryCount(Count + 1)).
    

addItem(Item, 1, Level) :- 
    inventoryList(Item, ItemCount, _),
    retract(inventoryList(Item, _, _)),
    asserta(inventoryList(Item, ItemCount + 1, Level)).
    retract(inventoryCount(Count)),
    asserta(inventoryCount(Count + 1)).
    
addItem(Item, Count, Level) :-
    addItem(Item, 1, Level),
    NewCount is Count - 1,
    addItem(Item, NewCount, Level).
    
% Delete item from inventory
deleteItem(Item, 1, _) :-
    \+inventoryList(Item, _, _), !, fail.

deleteItem(Item, 1, Level) :-
    inventoryList(Item, ItemCount, _),
    retract(inventoryList(Item, _, _)),
    asserta(inventoryList(Item, ItemCount - 1, Level)).
    retract(inventoryCount(Count)),
    asserta(inventoryCount(Count - 1)).

deleteItem(Item, Count, Level) :-
    deleteItem(Item, 1, Level),
    NewCount is Count - 1,
    deleteItem(Item, NewCount, Level).
