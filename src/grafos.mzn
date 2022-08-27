% Definición de variables
% Número de aristas
int: M;

% Array de aristas
array[1..M, 1..2] of int: aristas = [|3 , 2 |3 , 11 |13 , 8 |6 , 13 |9 , 1 |4 , 12 |5 , 14 |12 , 2 |14 , 11 |11 , 3 |7 , 8 |6 , 3 |7 , 3 |8 , 13 |4 , 10 |5 , 13 |14 , 6 |5 , 6 |13 , 1 |3 , 13 |12 , 1 |10 , 5 |9 , 11 |2 , 14 |1 , 13 |13 , 3 |7 , 3 |14 , 3 |11 , 10 |4 , 3 |12 , 6 |13 , 2 |1 , 3 |8 , 11 |11 , 3 |13 , 3 |3 , 13 |6 , 3 |3 , 8 |3 , 13 |11 , 9 |1 , 4 |7 , 13 |1 , 9 |7 , 2 |9 , 5 |3 , 6 |3 , 10 |11 , 6 |14 , 4 |3 , 4 |14 , 13 |5 , 9 |1 , 8 |7 , 5 |5 , 6 |9 , 6 |6 , 2 |3 , 9 |8 , 9 |1 , 9 |10 , 7 |11 , 13 |11 , 5 |5 , 2 |11 , 13 |1 , 4 |5 , 14 |3 , 13 |9 , 6 |7 , 5 |9 , 13 |7 , 12 |4 , 11 |14 , 7 |11 , 9 |8 , 3 |9 , 1 |1 , 9 |5 , 9 |6 , 1 |4 , 3 |10 , 12 |3 , 11 |3 , 11 |3 , 14 |5 , 11 |10 , 9 |2 , 10 |4 , 14 |11 , 1 |];




% Array de colores para aristas
array[1..M] of var 1..M: colores;
 
% Definición de restricciones
% El color de todas las que compartan un nodo como extremo debe ser distinto
constraint forall(i in 1..M, j in 1..M) 
(if i != j /\ (aristas[i,1] == aristas[j,1] /\ aristas[i,2] == aristas[j,2]) then
colores[i] == colores[j] endif);

constraint forall(i in 1..M, j in 1..M) 
(if i != j /\ (aristas[i,1] == aristas[j,2] /\ aristas[i,2] == aristas[j,1]) then
colores[i] == colores[j] endif);

constraint forall(i in 1..M, j in 1..M) 
(if i != j /\ ((aristas[i,1] == aristas[j,1] /\ aristas[i,2] != aristas[j,2]) \/
(aristas[i,1] != aristas[j,1] /\ aristas[i,2] == aristas[j,2]) \/
(aristas[i,2] == aristas[j,1] /\ aristas[i,1] != aristas[j,2]) \/
(aristas[i,2] != aristas[j,1] /\ aristas[i,1] == aristas[j,2]))
then
colores[i] != colores[j] endif);

output["Número de colores mínimo -> \(max(colores))"];

solve minimize max(colores);

