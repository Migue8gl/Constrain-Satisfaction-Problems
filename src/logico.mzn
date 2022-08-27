include "globals.mzn";
% Definición de variables:
array[1..5] of string:per=["vasco", "gallego", "andaluz", "navarro", "catalan"];
array[1..5] of string:prof=["violinista", "escultor","pintor","medico","diplomatico"];
array[1..5] of string:cas=["roja", "blanca", "amarilla", "verde", "azul"];
array[1..5] of string:bebi=["zumo", "te", "cafe","agua","leche"];
array[1..5] of string:anim=["caballo", "cebra", "caracoles", "perro", "zorro"];

array[1..5,1..5] of var 1..5:casas;

% Definición de restricciones:
% Andaluz vive en primera casa a la izquierda
constraint casas[1,1] == 3;
% Vasco vive en casa roja
constraint forall(i in 1..5 where casas[i,1] == 1) (casas[i,3] == 1);
% Catalán tiene un perro
constraint forall(i in 1..5 where casas[i,1] == 5) (casas[i,5] == 4);
% Gallego es pintor
constraint forall(i in 1..5 where casas[i,1] == 2) (casas[i,2] == 3);
% Navarro bebe te
constraint forall(i in 1..5 where casas[i,1] == 4) (casas[i,4] == 2);
% El de la casa verde bebe café
constraint forall(i in 1..5 where casas[i,3] == 4) (casas[i,4] == 3);
% La casa verde está al lado de la casa blanca y a su derecha
constraint forall(i in 1..5 where casas[i,3] == 4) (i < 5 /\ casas[i+1,3] == 2);
% Escultor cría caracoles
constraint forall(i in 1..5 where casas[i,2] == 2) (casas[i,5] == 3);
% Diplomatico vive en casa amarilla
constraint forall(i in 1..5 where casas[i,2] == 5) (casas[i,3] == 3);
% Casa central se bebe leche
constraint casas[3,4] == 5;
% La casa del andaluz está al lado de la azul
constraint forall(i in 1..5 where casas[i,1] == 3) ((i < 5 /\ casas[i+1,3] == 5) \/
(i > 1 /\ casas[i-1,3] == 5));
% El violinista bebe zumo
constraint forall(i in 1..5 where casas[i,2] == 1) (casas[i,4] == 1);
% Zorro en casa de al lado del médico
constraint forall(i in 1..5 where casas[i,2] == 4) ((i < 5 /\ casas[i+1,5] == 5) \/
(i > 1 /\ casas[i-1,5] == 5));
% Caballo en casa de al lado del diplomático
constraint forall(i in 1..5 where casas[i,2] == 5) ((i < 5 /\ casas[i+1,5] == 1) \/
(i > 1 /\ casas[i-1,5] == 1));

constraint forall(j in 1..5) (alldifferent ([casas[i,j]|i in 1..5]));

output ["Solución:\n"];
output [ "\(casas[j,i]) " ++if i == 5 then "\n" else "" endif | j,i in 1..5];
output [if fix(casas[i,5])==2 then "\nLa cebra está en la casa \(cas[fix(casas[i,3])])" else "" endif | i in 1..5];
output [if fix(casas[i,4])==5 then "\nLa leche la toma el \(per[fix(casas[i,1])])" else "" endif | i in 1..5];

solve satisfy;