% Definición de variables:
% Array de cantidades de monedas, es decir, cada posición simboliza una moneda (1 cent, 2 cent etc...) y el elemento en esa posición es la cantidad de monedas que tenemos de ese valor concreto.
array[1..8] of var 0..infinity: x;
% Importe objetivo
int: y;
var int: num_monedas = sum(x);

% Definición de restricciones:
% La suma de las monedas con sus respectivos valores debe ser la del objetivo y
constraint x[1]*1 + x[2]*2 + x[3]*5 + x[4]*10 + x[5]*20 + x[6]*50 + x[7]*100 + x[8]*200 == y;
constraint x[1]*1 + x[2]*2 + x[3]*5 + x[4]*10 + x[5]*20 + x[6]*50 < 100;

output ["Número total de monedas -> \(num_monedas)\n"];
output ["Solución -> \(x)"];

solve minimize num_monedas;