
Para utilizar la funcion mincua, se le debe indicar los puntos (x,Y) por los cuales
se quiere aproximar. Se los indica como dos vectores por separados:
x = [1 2 3 4];
y = [1 2 3 4];

Luego se indica el orden del polinomio por el cual se desea aproximar en la variable n.
Por ejemplo para un cuadratica n valdria 2.

Finalmente se llama a la funcion de la siguiente forma:

r=mincua(x,y,n);

La misma devuelve los coeficientes del polinomio por el cual aproximo