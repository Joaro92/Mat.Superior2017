%pkg load control;
%pkg load signal;
clear

%global x = [1 2 3 4];
%global y = [5 10 20 50];
global xs = [1; 2; 3; 4];
global ys = [5; 10; 20; 50];


global n;


%source("funciones.m");

% Deshabilita los botones de menu que vienen por defecto
% f = figure("MenuBar","None");

% La propiedad handlevisibility hace que no se limpie ese widget al llamar a clf

%btn_ingresar = uimenu(f, "label", "Ingresar Datos", "handlevisibility", "off");

%mostar = uimenu("label", "mostrar", "callback", "msgbox(sprintf(Valor de X: %i\n Valor de Y: %i\n Valor de N: %i\n, x, y, n))");%, "handlevisibility", "off");

mostar = uimenu("label", "mostrar", "callback", "mostrarvalores");

btn_ingresar = uimenu("label", "Ingresar Datos");%, "handlevisibility", "off");
  btn_conjuntosPuntos = uimenu(btn_ingresar, "label", "Ingresar Conjunto de Puntos", "callback", "dlg_ingresar_conjuntosPuntos");

%btn_funciones = uimenu(f, "label", "Funciones", "callback", "off");  
  
btn_funciones = uimenu("label", "Funciones");

btn_aproximacion_elegir = uimenu(btn_funciones, "label", "Aproximar Mediante:");
  
  %btn_recta = uimenu(btn_aproximacion_elegir, "label", "Recta de mínimos cuadrados", "callback", "show_recta");
  btn_recta = uimenu(btn_aproximacion_elegir, "label", "Función Recta", "callback", "lineal(xs,ys)");
  btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Función Parabola", "callback", "cuadratica(xs,ys)");
  btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Función Exponencial", "callback", "exponencial(xs,ys)");
  btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Función Potencial", "callback", "potencial(xs,ys)");
  btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Función Hipérbóla", "callback", "hiperbola(xs,ys)");

btn_graf_pc = uimenu("label", "Graficar Aproximación", "callback", "graficar");
btn_comparacion = uimenu("label", "Comparar Aproximaciones", "callback", "comparar");
btn_salir = uimenu("Label", "Salir", "handlevisibility", "off", "callback", "close(gcf)");

box on;
axis off;
text(0.15,0.8,"Bienvenido a ", "fontsize", 30);
text(0.625,0.8,"AMIC", "fontsize", 30,"color","red","fontweight","bold");
text(0.14,0.4,"Para comenzar ingrese un conjunto de puntos", "fontsize", 15,"color","red");


function dlg_ingresar_conjuntosPuntos
  
  global n;
  
  numero = inputdlg("Ingresar el conjunto de puntos");
  
  disp(numero);
  
  n = str2double(numero);
  
  disp(n);
  drawnow ("expose");
  
endfunction


function mostrarvalores
  
  global n;
  
  msgbox(disp(n));
  
endfunction

function w=lineal(xs, ys)
  M = [xs ys];
  p = rows(xs);
  sumaX = sum(M)(1,1);
  sumaY = sum(M)(1,2);
  sumaXporY = 0;
  for i = 1:p
    sumaXporY += M(i,1) * M(i,2);
  endfor;
  M2 = M .* M;
  sumaXcuadrado = sum(M2)(1,1);
  clear M2;

  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  
  printf("\nLa respuesta es a = %i y b = %i\n", a, b)
  if (b < 0)
    func = sprintf("f(x) = %i*x + (%i)", a, b)
  elseif
    func = sprintf("f(x) = %i*x + %i", a, b)
  endif;
  
  x=linspace(min(xs)-2, max(xs)+2, 1000);
  plot(x, a*x+b, xs, ys, "*r");
  title(func);
  xlabel('"Aprox. Lineal"', 'FontSize', 22, 'fontweight', "bold");
endfunction 

function w=cuadratica(xs, ys)
  M = [xs ys];
  p = rows(xs);
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

  A = [ sumaXcuarta sumaXcubo sumaXcuadrado
        sumaXcubo sumaXcuadrado sumaX
        sumaXcuadrado sumaX p ];
  B = [ sumaX2porY ; sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  c = X(3,1);
  printf("\nLa respuesta es a = %i, b = %i y c = %i\n", a, b, c);
  if (b < 0)
    if (c < 0)
      func = sprintf("f(x) = %i*x^2 + (%i)*x + (%i)", a, b, c)
    elseif
      func = sprintf("f(x) = %i*x^2 + (%i)*x + %i", a, b, c)
    endif;
  else
    if (c < 0)
      func = sprintf("f(x) = %i*x^2 + %i*x + (%i)", a, b, c)
    elseif
      func = sprintf("f(x) = %i.x^2 + %i.x + %i", a, b, c)
    endif;
  endif;
  
  x=linspace(min(xs)-2, max(xs)+2, 1000);
  plot(x, a*(x.^2) + b*x + c, xs, ys, "*r");
  title(func);
  xlabel('"Aprox. Cuadratica"', 'FontSize', 22, 'fontweight', "bold");
endfunction

function w=exponencial(xs, ys)
  M = [xs ys];
  p = rows(xs);
  sumaX = sum(M)(1,1);
  M2 = M .* M;
  sumaXcuadrado = sum(M2)(1,1);
  clear M2;
  sumaXporLogY = 0;
  for i = 1:p
    sumaXporLogY += M(i,1) * log(M(i,2));
  endfor;
  sumaLogY = 0;
  for i = 1:p
    sumaLogY += log(M(i,2));
  endfor; 
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  printf("\nLa respuesta es a = %i y b = %i\n", a, b);
  func = sprintf("f(x) = %i*e^^(%i*x)", b, a)
  
  x=linspace(min(xs)-2, max(xs)+2, 1000);
  plot(x, b*e.^(a*x), xs, ys, "*r");
  title(func);
  xlabel('"Aprox. Exponencial"', 'FontSize', 22, 'fontweight', "bold");
endfunction

function w=potencial(xs, ys)
  M = [xs ys];
  p = rows(xs);
  sumaLogX2 = 0;
  for i = 1:p
    sumaLogX2 += (log(M(i,1))) ^ 2;
  endfor;
  sumaLogXporLogY = 0;
  for i = 1:p
    sumaLogXporLogY += log(M(i,1)) * log(M(i,2));
  endfor;
  sumaLogY = 0;
  for i = 1:p
    sumaLogY += log(M(i,2));
  endfor;
  sumaLogX = 0;
  for i = 1:p
    sumaLogX += log(M(i,1));
  endfor;
  
  A = [ sumaLogX2 sumaLogX ; sumaLogX p ];
  B = [ sumaLogXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  printf("\nLa respuesta es a = %i y b = %i\n", a, b);
  func = sprintf("f(x) = %i*x^^(%i)", b, a)
  
  x=linspace(min(xs)-2, max(xs)+2, 1000);
  plot(x, b*x.^(a), xs, ys, "*r");
  title(func);
  xlabel('"Aprox. Potencial"', 'FontSize', 22, 'fontweight', "bold");
endfunction

function w=hiperbola(xs, ys)
  M = [xs ys];
  p = rows(xs);
  sumaX = sum(M)(1,1);
  M2 = M .* M;
  sumaXcuadrado = sum(M2)(1,1);
  clear M2;
  sumaXporInvY = 0;
  for i = 1:p
    sumaXporInvY += M(i,1) * (1 / M(i,2));
  endfor;
  sumaInvY = 0;
  for i = 1:p
    sumaInvY += 1 / M(i,2);
  endfor;
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporInvY ; sumaInvY ];
  AI = inv(A);
  X = AI*B;
  a = 1 / X(1,1);
  b = a * X(2,1);
  printf("\nLa respuesta es a = %i y b = %i\n", a, b);
  if (b < 0)
    func = sprintf("f(x) = %i / (x + (%i))", a, b)
  elseif
    func = sprintf("f(x) = %i / (x + %i)", a, b)
  endif;
  
  x=linspace(min(xs)-2, max(xs)+2, 1000);
  plot(x, a./(x+b), xs, ys, "*r");
  title(func);
  xlabel('"Aprox. Hiperbólica"', 'FontSize', 22, 'fontweight', "bold");
endfunction