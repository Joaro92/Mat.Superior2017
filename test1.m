%INGRESAR LOS PUNTOS (EN EL FORMATO [x,y] o [x y])
clear M;
p = input ("Defina cuantos puntos va a ingresar: ");
for i = 1:p
  printf("Ingrese punto %i", i);
  M(i, [1,2]) = input(" = ");
endfor;
M

%CALCULA LOS VALORES NECESARIOS
printf("------------------\nAPROXIMACION LINEAL\n\n");
sumaX = sum(M)(1,1)
sumaY = sum(M)(1,2)
sumaXporY = 0;
for i = 1:p
  sumaXporY += M(i,1) * M(i,2);
endfor;
sumaXporY
M2 = M .* M;
sumaXcuadrado = sum(M2)(1,1)
clear M2;
A = [ sumaXcuadrado sumaX ; sumaX p ]
B = [ sumaXporY ; sumaY ]
AI = inv(A)
X = AI*B;
a = X(1,1);
b = X(2,1);

%IMPRIMO EL RESULTADO
printf("\nLa respuesta es a = %i y b = %i", a, b);
if (b < 0)
  printf("\nLa funcion aproximada es < y = %i.x + (%i) >\n", a, b);
elseif
  printf("\nLa funcion aproximada es < y = %i.x + %i >\n", a, b);
endif