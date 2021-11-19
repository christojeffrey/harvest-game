% fakta mengenai status
:- dynamic(level/1).
:- dynamic(class/1).
:- dynamic(levelFarming/1).
:- dynamic(levelFishing/1).
:- dynamic(levelRanching/1).
:- dynamic(expFarming/1).
:- dynamic(expFishing/1).
:- dynamic(expRanching/1).
:- dynamic(gold/1).
:- dynamic(exp/1).

% fakta mengenai map
:- dynamic(barisMap/1).
:- dynamic(kolomMap/1).
:- dynamic(playerLoc/2).
:- dynamic(marketPlaceLoc/2).
:- dynamic(ranchLoc/2).
:- dynamic(houseLoc/2).
:- dynamic(questLoc/2).
:- dynamic(waterLoc/2).
:- dynamic(diggedLoc/2).

% fakta mengenai quest
:- dynamic(checkQuest/1).
:- dynamic(quest/3).
:- dynamic(submitQuest/3).

% fakta mengenai inventory
:- dynamic(inventoryList/1).