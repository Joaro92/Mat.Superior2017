clear

global xs = [1; 2; 3];
global ys = [5; 10; 15];

global func;

global p;
global sumaX;
global sumaY;
global sumaXporY;
global sumaX2porY;
global sumaXcuadrado;
global sumaXcubo;
global sumaXcuarta;
global sumaXporLogY;
global sumaXporInvY;
global sumaLogX;
global sumaLogX2;
global sumaLogXporLogY;
global sumaLogY;
global sumaInvY;

global errores = struct("lineal", 0, "cuadratica", 0, "exponencial", 0, "potencial", 0, "hiperbola", 0); 

function w=lineal(x)
  global errores;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaY;
  global sumaXporY;
  global sumaXcuadrado;
  global func;
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);

  func = sprintf("f(x) = %i*x%+i", a, b);
  w = a.*x+b;
  E = 0;
  for i = 1:rows(xs)
    E += (ys(i) - (a.*xs(i)+b))^2;
  endfor;
  %Redondeo a 5 decimales
  E = sprintf("%8.5f",E)
  errores.("lineal") = str2num(E);
endfunction 

function w=cuadratica(x)
  global errores;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaY;
  global sumaXporY;
  global sumaX2porY;
  global sumaXcuadrado;
  global sumaXcubo;
  global sumaXcuarta;
  global func;
  
  A = [ sumaXcuarta sumaXcubo sumaXcuadrado
        sumaXcubo sumaXcuadrado sumaX
        sumaXcuadrado sumaX p ];
  B = [ sumaX2porY ; sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  c = X(3,1);
  
  func = sprintf("f(x) = %i*x^2%+i*x%+i", a, b, c);
  w = a.*x.^2 + b.*x + c;
  
  E = 0;
  for i = 1:rows(xs)
    E += (ys(i) - (a.*xs(i).^2 + b.*xs(i) + c))^2;
  endfor;
  %Redondeo a 5 decimales
  E = sprintf("%8.5f",E);
  errores.("cuadratica") = str2num(E);
endfunction

function w=exponencial(x)
  global errores;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaXcuadrado;
  global sumaXporLogY;
  global sumaLogY;
  global func;
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  
  func = sprintf("f(x) = %i*e^^(%i*x)", b, a);
  w = b.*e.^(a.*x);
  
  E = 0;
  for i = 1:rows(xs)
    E += (ys(i) - (b.*e.^(a.*xs(i))))^2;
  endfor;
  %Redondeo a 5 decimales
  E = sprintf("%8.5f",E);
  errores.("exponencial") = str2num(E);
endfunction

function w=potencial(x)
  global errores;
  global xs;
  global ys;
  global p;
  global sumaLogX2;
  global sumaLogX;
  global sumaLogXporLogY;
  global sumaLogY;
  global func;
  
  A = [ sumaLogX2 sumaLogX ; sumaLogX p ];
  B = [ sumaLogXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  
  func = sprintf("f(x) = %i*x^^(%i)", b, a);
  w = b.*x.^a;
  
  E = 0;
  for i = 1:rows(xs)
    E += (ys(i) - (b.*xs(i).^a))^2;
  endfor;
  %Redondeo a 5 decimales
  E = sprintf("%8.5f",E);
  errores.("potencial") = str2num(E);
endfunction

function w=hiperbola(x)
  global errores;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaXcuadrado;
  global sumaXporInvY;
  global sumaInvY;
  global func;
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporInvY ; sumaInvY ];
  AI = inv(A);
  X = AI*B;
  a = 1 / X(1,1);
  b = a * X(2,1);
  
  func = sprintf("f(x) = %i / (x%+i)", a, b);
  w = a./(x+b);
  
  E = 0;
  for i = 1:rows(xs)
    E += (ys(i) - (a./(xs(i)+b)))^2;
  endfor;
  %Redondeo a 5 decimales
  E = sprintf("%8.5f",E);
  errores.("hiperbola") = str2num(E);
endfunction

function calcularValores(xs,ys)
  global p;
  global sumaX;
  global sumaY;
  global sumaXporY;
  global sumaX2porY;
  global sumaXcuadrado;
  global sumaXcubo;
  global sumaXcuarta;
  global sumaXporLogY;
  global sumaXporInvY;
  global sumaLogX;
  global sumaLogX2;
  global sumaLogXporLogY;
  global sumaLogY;
  global sumaInvY;
  
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
endfunction

function resolverFunciones(xs)
  x = linspace(min(xs), max(xs));
  lineal(x);
  cuadratica(x);
  exponencial(x);
  potencial(x);
  hiperbola(x);
endfunction

% Deshabilita los botones de menu que vienen por defecto
%f = figure("MenuBar","None");
calcularValores(xs,ys);
resolverFunciones(xs);

% Ventana Principal
figure('Position',[400,120,570,380]);
box on;
axis off;
text(0.15,0.8,"Bienvenido a ", "fontsize", 30);
text(0.625,0.8,"AMIC", "fontsize", 30,"color","red","fontweight","bold");
text(0.11,0.4,"Para comenzar ingrese un conjunto de puntos", "fontsize", 15,"color","red");


btn_ingresar = uimenu("label", "Ingresar");%, "handlevisibility", "off");
  btn_conjuntosPuntos = uimenu(btn_ingresar, "label", "Conjunto de Puntos", "callback", "dlg_ingresar_conjuntosPuntos");

btn_mostrar = uimenu("label", "Mostrar Puntos", "callback", "mostrarvalores(xs,ys)");
  
btn_funciones = uimenu("label", "Funciones");
  btn_aproximacion_elegir = uimenu(btn_funciones, "label", "Aproximar Mediante:");
    btn_recta = uimenu(btn_aproximacion_elegir, "label", "Función Recta", "callback", 'graficar(xs,ys,"lineal")');
    btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Función Parabola", "callback", 'graficar(xs,ys,"cuadratica")');
    btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Función Exponencial", "callback", 'graficar(xs,ys,"exponencial")');
    btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Función Potencial", "callback", 'graficar(xs,ys,"potencial")');
    btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Función Hipérbóla", "callback", 'graficar(xs,ys,"hiperbola")');

btn_comparacion = uimenu("label", "Comparar Aproximaciones", "callback", "comparar");
btn_salir = uimenu("label", "Salir", "handlevisibility", "off", "callback", "close(gcf)");

function dlg_ingresar_conjuntosPuntos
  global xs;
  aux1 = inputdlg("Ingresar el conjunto de x (Separados por punto y coma ';')");
  aux2 = cell2mat(aux1);
  x = cstrcat("[",aux2,"]");

  global ys;
  aux1 = inputdlg("Ingresar el conjunto de y (Separados por punto y coma ';')");
  aux2 = cell2mat(aux1);
  y = cstrcat("[",aux2,"]");
  
  xs = str2num(x);
  ys = str2num(y);
  
  calcularValores(xs,ys);
  resolverFunciones(xs);
endfunction

function graficar(xs,ys,funcion)
  global func;
  f = str2func(funcion);
  
  x = linspace(min(xs)-2, max(xs)+2);
  plot(x, f(x), xs, ys, "*r");
  xlabel(func);
  title(cstrcat("Aprox. ", funcion), 'FontSize', 20, 'fontweight', "bold");
endfunction

function mostrarvalores(xs,ys)
  puntos = cstrcat("Conjunto de x = [ ", num2str(rot90(xs)), " ]\n", "Conjunto de y = [ ", num2str(rot90(ys)), " ]");
  msgbox(puntos, "Conjunto de Puntos");
endfunction
  
