:- include('globalFact.pl').
:- include('globalRule.pl').

farmItems(wheat).
farmItems(corn).
farmItems(carrot).

fishItems(tuna).
fishItems(salmon).
fishItems(catfish).

ranchItems(wool).
ranchItems(egg).
ranchItems(milk).

checkQuest() :- quest(_,_,_,_,_,_).

allFarmItems(X) :- findall(X, (farmItems(X)), X).
allFishItems(X) :- findall(X, (fishItems(X)), X).
allRanchItems(X) :- findall(X, (ranchItems(X)), X).

quest :-
    (\+ checkQuest(),
    allFarmItems(FarmList),
    allFishItems(FishList),
    allRanchItems(RanchList),
    random_member(FarmItem, FarmList),
    random_member(FishItem, FishList),
    random_member(RanchItem, RanchList),
    random(1, 11, FarmQty),
    random(1, 11, FishQty),
    random(1, 11, RanchQty),
    assertz(quest(FarmQty, FishQty, RanchQty, FarmItem, FishItem, RanchItem)),
    write('You got a new quest!'), nl,
    nl,
    write('You need to collect:'), nl,
    write('- '), write(FarmQty), write(' '), write(FarmItem), nl,
    write('- '), write(FishQty), write(' '), write(FishItem), nl,
    write('- '), write(RanchQty), write(' '), write(RanchItem));
    (checkQuest(),
    quest(FarmQty, FishQty, RanchQty, FarmItem, FishItem, RanchItem),
    write('You already have an ingoing quest!'), nl,
    write('Your current quest is : '), nl,
    write('You need to collect:'), nl,
    write('- '), write(FarmQty), write(' '), write(FarmItem), nl,
    write('- '), write(FishQty), write(' '), write(FishItem), nl,
    write('- '), write(RanchQty), write(' '), write(RanchItem), nl, nl
    % tambahin status barang sekarang
    ).
    
