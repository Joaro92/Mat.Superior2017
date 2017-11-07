clear

global xs = [1; 2; 3; 4];
global ys = [5; 10; 20; 50];

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

% Deshabilita los botones de menu que vienen por defecto
%f = figure("MenuBar","None");
calcularValores(xs,ys);

% Ventana Principal
figure('Position',[400,120,570,380]);
box on;
axis off;
text(0.15,0.8,"Bienvenido a ", "fontsize", 30);
text(0.625,0.8,"AMIC", "fontsize", 30,"color","red","fontweight","bold");
text(0.11,0.4,"Para comenzar ingrese un conjunto de puntos", "fontsize", 15,"color","red");

mostar = uimenu("label", "mostrar", "callback", "mostrarvalores");

btn_ingresar = uimenu("label", "Ingresar Datos");%, "handlevisibility", "off");
  btn_conjuntosPuntos = uimenu(btn_ingresar, "label", "Ingresar Conjunto de Puntos", "callback", "dlg_ingresar_conjuntosPuntos");

btn_funciones = uimenu("label", "Funciones");
  btn_aproximacion_elegir = uimenu(btn_funciones, "label", "Aproximar Mediante:");
    btn_recta = uimenu(btn_aproximacion_elegir, "label", "Función Recta", "callback", 'graficar(xs,ys,"lineal")');
    btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Función Parabola", "callback", 'graficar(xs,ys,"cuadratica")');
    btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Función Exponencial", "callback", 'graficar(xs,ys,"exponencial")');
    btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Función Potencial", "callback", 'graficar(xs,ys,"potencial")');
    btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Función Hipérbóla", "callback", 'graficar(xs,ys,"hiperbola")');

btn_graf_pc = uimenu("label", "Graficar Aproximación", "callback", "graficar");
btn_comparacion = uimenu("label", "Comparar Aproximaciones", "callback", "comparar");
btn_salir = uimenu("label", "Salir", "handlevisibility", "off", "callback", "close(gcf)");

function dlg_ingresar_conjuntosPuntos
  
  global n;
  
  numero = inputdlg("Ingresar el conjunto de puntos");
  
  disp(numero);
  
  n = str2double(numero);
  
  disp(n);
  drawnow ("expose");
  
endfunction

function graficar(xs,ys,funcion)
  global func;
  f = str2func(funcion);
  
  x = linspace(min(xs)-2, max(xs)+2, 1000);
  plot(x, f(x), xs, ys, "*r");
  xlabel(func);
  title(cstrcat("Aprox. ", funcion), 'FontSize', 20, 'fontweight', "bold");
endfunction

function mostrarvalores
  
  global n;
  
  msgbox(disp(n));
  
endfunction

function todos
  lineal(x);
  cuadratica(x);
  exponencial(x);
  potencial(x);
  hiperbola(x);
endfunction
  
function w=lineal(x)
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
  
  func = sprintf("f(x) = %i*x%+i", a, b)
  w = a.*x+b;
endfunction 

function w=cuadratica(x)
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
  
  func = sprintf("f(x) = %i*x^2%+i*x%+i", a, b, c)
  w = a.*x.^2 + b.*x + c;
endfunction

function w=exponencial(x)
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
  
  func = sprintf("f(x) = %i*e^^(%i*x)", b, a)
  w = b.*e.^(a.*x);
endfunction

function w=potencial(x)
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
  
  func = sprintf("f(x) = %i*x^^(%i)", b, a)
  w = b.*x.^a;
endfunction

function w=hiperbola(x)
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
  
  func = sprintf("f(x) = %i / (x%+i)", a, b)
  w = a./(x+b);
endfunction

