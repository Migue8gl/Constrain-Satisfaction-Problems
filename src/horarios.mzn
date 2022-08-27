include "globals.mzn";
% Definición de variables:
array[1..5,1..6] of var 0..9: horario;
set of int: bloques2 = {1,3,4,5,8};
set of int: bloques1 = {2,6,7,9};
set of int: prof1 = {1,3}; set of int: prof2 = {4,5};
set of int: prof3 = {6,9}; set of int: prof4 = {2,7,8};

% Definición de restricciones
% El recreo (cuarta hora) debe estar vacío de asignaturas
constraint forall(i in 1..5)(horario[i,4]==0);

% No debe impartirse más de un bloque de cada asignatura por día, por ello la suma de las veces que se repite esa asignatura ese día no debe superar sus horas mínimas de bloque.
constraint
(count([horario[1,j]| j in 1..6],1) == 2 \/ count([horario[2,j]| j in 1..6],1) == 2) /\ 
(count([horario[3,j]| j in 1..6],3) == 2 \/ count([horario[4,j]| j in 1..6],3) == 2) /\ 
(count([horario[1,j]| j in 1..6],4) == 2 \/ count([horario[2,j]| j in 1..6],4) == 2) /\ 
(count([horario[4,j]| j in 1..6],5) == 2 \/ count([horario[5,j]| j in 1..6],5) == 2) /\
(count([horario[3,j]| j in 1..6],6) == 1 \/ count([horario[5,j]| j in 1..6],6) == 1) /\
(count([horario[2,j]| j in 1..6],7) == 1 \/ count([horario[5,j]| j in 1..6],7) == 1) /\
count([horario[3,j]| j in 1..6],8) == 2 /\ 
count([horario[1,j]| j in 1..6],9) == 1;

% La suma de los días donde se imparte cierta asignatura, debe ser igual a la cantidad de horas totales de esa asignatura concreta
constraint
(count([horario[1,j]| j in 1..6],1) + count([horario[2,j]| j in 1..6],1) == 4) /\ 
(count([horario[3,j]| j in 1..6],3) + count([horario[4,j]| j in 1..6],3) == 4) /\ 
(count([horario[1,j]| j in 1..6],4) + count([horario[2,j]| j in 1..6],4) == 4) /\ 
(count([horario[4,j]| j in 1..6],5) + count([horario[5,j]| j in 1..6],5) == 4) /\
(count([horario[3,j]| j in 1..6],6) + count([horario[5,j]| j in 1..6],6) == 2) /\
(count([horario[2,j]| j in 1..6],7) + count([horario[5,j]| j in 1..6],7) == 2) /\
count(horario[1..5,1..6],2) == 2;

% Las horas dobles deben ser consecutivas
constraint forall (i in 1..5,j in 1..6 where horario[i,j] in bloques2) 
((j < 6 /\ (horario[i,j] == horario[i,j+1])) \/ (j > 1 /\ (horario[i,j] == horario[i,j-1])));

% Excepto el recreo, no puede haber horas vacías
constraint forall (i in 1..5,j in 1..6) (j == 4 \/ horario[i,j] != 0);

% El profesor uno imparte sus asignaturas solo en las dos últimas horas
constraint forall (i in 1..5, j in 1..6) 
(j >= 5 \/ (horario[i,j] != prof1[1] /\ horario[i,j] != prof1[2]));

% El profesor dos imparte sus asignaturas solo en las dos primeras horas
constraint forall (i in 1..5, j in 1..6) 
(j <= 2 \/ (horario[i,j] != prof2[1] /\ horario[i,j] != prof2[2]));

% El profesor tres imparte sus asignaturas solo en la hora anterior al recreo
constraint forall (i in 1..5, j in 1..6) 
(j == 3 \/ (horario[i,j] != prof3[1] /\ horario[i,j] != prof3[2]));

output ["Solución:\n"];
output [ "\(horario[i,j]) " ++if i == 5 then "\n" else "" endif | j in 1..6,i in 1..5];

solve satisfy;