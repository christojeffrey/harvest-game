% --fakta mengenai status--
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
:- dynamic(lebarMap/1).
:- dynamic(tinggiMap/1).
:- dynamic(playerLoc/2).
:- dynamic(marketPlaceLoc/2).
:- dynamic(ranchLoc/2).
:- dynamic(houseLoc/2).
:- dynamic(questLoc/2).
:- dynamic(waterLoc/2).
:- dynamic(diggedLoc/2).

% terdapat tiga parameter. baris, kolom, dan juga nama tanaman. contoh (1,5,corn), artinya di baris 1, kolom 5, dan yang di tanam adalah corn
:- dynamic(plantedLoc/3). 

% --fakta mengenai quest--
:- dynamic(checkQuest/0).
:- dynamic(quest/6).
:- dynamic(submitQuest/6).

% --fakta mengenai inventory--
:- dynamic(inventoryList/3).

% --fakta mengenai time--
:- dynamic(currentTime/1).

% --fakta mengenai day--
:- dynamic(currentDay/1).

% fakta mengenai 'rule yang dapat diakses'. saat game berlangsung, hanya ada boleh satu satu buah fakta ini. jadi jangan lupa melakukan retract jika ingin melakukan penggantian
:- dynamic(playerState/1).

farmItems(wheat).
farmItems(corn).
farmItems(carrot).

fishItems(tuna).
fishItems(salmon).
fishItems(catfish).

ranchItems(wool).
ranchItems(egg).
ranchItems(milk).

