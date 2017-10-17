%INGRESAR LOS PUNTOS (EN EL FORMATO [x,y] o [x y])
clear M;
p = input ("Defina cuantos puntos va a ingresar: ");
for i = 1:p
  printf("Ingrese punto %i", i);
  M(i, [1,2]) = input(" = ");
endfor;
M

%CALCULA LOS VALORES NECESARIOS (Sumatorias)
sumaX = sum(M)(1,1);
sumaY = sum(M)(1,2);
sumaXporY = 0;
for i = 1:p
  sumaXporY += M(i,1) * M(i,2);
endfor;
sumaX2porY = 0;
for i = 1:p
  sumaX2porY += M(i,1)^2 * M(i,2);
endfor;
M2 = M .* M;
sumaXcuadrado = sum(M2)(1,1);
M3 = M .* M .* M;
sumaXcubo = sum(M3)(1,1);
M4 = M .* M .* M .* M;
sumaXcuarta = sum(M4)(1,1);
clear M2;
clear M3;
clear M4;
sumaXporLogY = 0;
for i = 1:p
  sumaXporLogY += M(i,1) * log(M(i,2));
endfor;
sumaLogY = 0;
for i = 1:p
  sumaLogY += log(M(i,2));
endfor;
sumaLogX = 0;
for i = 1:p
  sumaLogX += log(M(i,1));
endfor;
sumaLogX2 = 0;
for i = 1:p
  sumaLogX2 += (log(M(i,1))) ^ 2;
endfor;
sumaLogXporLogY = 0;
for i = 1:p
  sumaLogXporLogY += log(M(i,1)) * log(M(i,2));
endfor;
sumaXporInvY = 0;
for i = 1:p
  sumaXporInvY += M(i,1) * (1 / M(i,2));
endfor;
sumaInvY = 0;
for i = 1:p
  sumaInvY += 1 / M(i,2);
endfor;

%FUNCION LINEAL
printf("-------------------\nAPROXIMACION LINEAL\n");
A = [ sumaXcuadrado sumaX ; sumaX p ];
B = [ sumaXporY ; sumaY ];
AI = inv(A);
X = AI*B;
a = X(1,1);
b = X(2,1);
printf("\nLa respuesta es a = %i y b = %i", a, b);
if (b < 0)
  printf("\nLa funcion aproximada es < y = %i.x + (%i) >\n", a, b);
elseif
  printf("\nLa funcion aproximada es < y = %i.x + %i >\n", a, b);
endif;
clear A;
clear B;
clear AI;
clear X;
clear a;
clear b;

%FUNCION CUADRATICA
printf("-------------------\nAPROXIMACION CUADRATICA\n");
A = [ sumaXcuarta sumaXcubo sumaXcuadrado
      sumaXcubo sumaXcuadrado sumaX
      sumaXcuadrado sumaX p ];
B = [ sumaX2porY ; sumaXporY ; sumaY ];
AI = inv(A);
X = AI*B;
a = X(1,1);
b = X(2,1);
c = X(3,1);
printf("\nLa respuesta es a = %i, b = %i y c = %i", a, b, c);
if (b < 0)
  if (c < 0)
    printf("\nLa funcion aproximada es < y = %i.x^2 + (%i).x + (%i) >\n", a, b, c);
  elseif
    printf("\nLa funcion aproximada es < y = %i.x^2 + (%i).x + %i >\n", a, b, c);  
  endif;
else
  if (c < 0)
    printf("\nLa funcion aproximada es < y = %i.x^2 + %i.x + (%i) >\n", a, b, c);
  elseif
    printf("\nLa funcion aproximada es < y = %i.x^2 + %i.x + %i >\n", a, b, c);
  endif;
endif;
clear A;
clear B;
clear AI;
clear X;
clear a;
clear b;
clear c;

%FUNCION EXPONENCIAL
printf("-------------------\nAPROXIMACION EXPONENCIAL\n");
A = [ sumaXcuadrado sumaX ; sumaX p ];
B = [ sumaXporLogY ; sumaLogY ];
AI = inv(A);
X = AI*B;
a = X(1,1);
b = exp(X(2,1));
printf("\nLa respuesta es a = %i y b = %i", a, b);
printf("\nLa funcion aproximada es < y = %i.e^(%i.x) >\n", b, a);
clear A;
clear B;
clear AI;
clear X;
clear a;
clear b;

%FUNCION POTENCIAL
printf("-------------------\nAPROXIMACION POTENCIAL\n");
A = [ sumaLogX2 sumaLogX ; sumaLogX p ];
B = [ sumaLogXporLogY ; sumaLogY ];
AI = inv(A);
X = AI*B;
a = X(1,1);
b = exp(X(2,1));
printf("\nLa respuesta es a = %i y b = %i", a, b);
printf("\nLa funcion aproximada es < y = %i.x^(%i) >\n", b, a);
clear A;
clear B;
clear AI;
clear X;
clear a;
clear b;

%FUNCION HIPERBOLICA
printf("-------------------\nAPROXIMACION HIPERBOLICA\n");
A = [ sumaXcuadrado sumaX ; sumaX p ];
B = [ sumaXporInvY ; sumaInvY ];
AI = inv(A);
X = AI*B;
a = 1 / X(1,1);
b = a * X(2,1);
printf("\nLa respuesta es a = %i y b = %i", a, b);
if (b < 0)
  printf("\nLa funcion aproximada es < y = %i / (x + (%i)) >\n", a, b);
elseif
  printf("\nLa funcion aproximada es < y = %i / (x + %i) >\n", a, b);
endif;
clear A;
clear B;
clear AI;
clear X;
clear a;
clear b;
