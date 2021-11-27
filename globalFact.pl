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
% plantedLoc(baris, kolom, nama, hari tanam, jam tanam).
% contoh plantedLoc(3,4,'corn', 2, 15).
:- dynamic(plantedLoc/5).


% fakta tentang items
% items(name, count, level).
:- dynamic(items/1).

% --fakta mengenai quest--
:- dynamic(checkQuest/0).
:- dynamic(quest/6).
:- dynamic(submitQuest/6).

% --fakta mengenai time--
:- dynamic(currentTime/1).

% --fakta mengenai day--
:- dynamic(currentDay/1).

% fakta mengenai 'rule yang dapat diakses'. saat game berlangsung, hanya ada boleh satu satu buah fakta ini. jadi jangan lupa melakukan retract jika ingin melakukan penggantian
% yang sudah dibuat, startGame, start, house, market
:- dynamic(playerState/1).

% fakta mengenai ranching (1 hari cuma bisa ranching 1 kali)
:- dynamic(chickenRanched/0).
:- dynamic(sheepRanched/0).
:- dynamic(cowRanched/0).