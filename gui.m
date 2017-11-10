clear

%% ++++++++++++++++++++++++ DEFINICIÓN DE VARIABLES ++++++++++++++++++++++++++
global xs = [1; 2; 3];
global ys = [5; 10; 15];
global A;
global B;
global a2;
global b2;
global c2;
global func;
global decimales = "5";
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
global error;

%% ++++++++++++++++++++++++++++ FUNCIONES ++++++++++++++++++++++++++++++++++++
function n=redondeo(num, decimales)
  aux = sprintf(cstrcat("%8.",decimales,"f"), num);
  n = str2num(aux);
endfunction

function s=elevado(cadena)
  s = "";
  t = length(cadena);
  for i = 1:t
    s = strcat(s, '^', cadena(i));
  endfor;
endfunction

function w=lineal(x)
  global error;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaY;
  global sumaXporY;
  global sumaXcuadrado;
  global func;
  global decimales;
  global A;
  global B;
  global a2;
  global b2;
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  
  a2 = redondeo(a,decimales);
  b2 = redondeo(b,decimales);
  func = sprintf("f(x) = %i*x%+i", a2, b2);
  f = a.*x+b;
  
  error = -1;
  if (any(xs == x))
    i = find(xs == x);
    error = (ys(i) - f).^2;
  endif
  
  w = f;
endfunction 

function w=cuadratica(x)
  global error;
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
  global decimales;
  global a2;
  global b2;
  global c2;
  
  A = [ sumaXcuarta sumaXcubo sumaXcuadrado
        sumaXcubo sumaXcuadrado sumaX
        sumaXcuadrado sumaX p ];
  B = [ sumaX2porY ; sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  c = X(3,1);
  
  a2 = redondeo(a,decimales);
  b2 = redondeo(b,decimales);
  c2 = redondeo(c,decimales);
  func = sprintf("f(x) = %i*x^2%+i*x%+i", a2, b2, c2);
  f = a.*x.^2 + b.*x + c;
  
  error = -1;
  if (any(xs == x))
    i = find(xs == x);
    error = (ys(i) - f).^2;
  endif
  
  w = f;
endfunction

function w=exponencial(x)
  global error;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaXcuadrado;
  global sumaXporLogY;
  global sumaLogY;
  global func;
  global decimales;
  global a2;
  global b2;
    
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  
  a2 = redondeo(a,decimales);
  b2 = redondeo(b,decimales);
  
  func = sprintf("f(x) = %i*e^(%i*x)", b2, a2);
  f = b.*e.^(a.*x);
  
  error = -1;
  if (any(xs == x))
    i = find(xs == x);
    error = (ys(i) - f).^2;
  endif
  
  w = f;
endfunction

function w=potencial(x)
  global error;
  global xs;
  global ys;
  global p;
  global sumaLogX2;
  global sumaLogX;
  global sumaLogXporLogY;
  global sumaLogY;
  global func;
  global decimales;
  global a2;
  global b2;
    
  A = [ sumaLogX2 sumaLogX ; sumaLogX p ];
  B = [ sumaLogXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  
  a2 = redondeo(a,decimales);
  b2 = redondeo(b,decimales);
  func = sprintf("f(x) = %i*x^(%i)", b2, a2);
  f = b.*x.^a;
  
  error = -1;
  if (any(xs == x))
    i = find(xs == x);
    error = (ys(i) - f).^2;
  endif
  
  w = f;
endfunction

function w=hiperbola(x)
  global error;
  global xs;
  global ys;
  global p;
  global sumaX;
  global sumaXcuadrado;
  global sumaXporInvY;
  global sumaInvY;
  global func;
  global decimales;
  global a2;
  global b2;
    
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporInvY ; sumaInvY ];
  AI = inv(A);
  X = AI*B;
  a = 1 / X(1,1);
  b = a * X(2,1);
  
  a2 = redondeo(a,decimales);
  b2 = redondeo(b,decimales);
  func = sprintf("f(x) = %i / (x%+i)", a2, b2);
  f = a./(x+b);
  
  error = -1;
  if (any(xs == x))
    i = find(xs == x);
    error = (ys(i) - f).^2;
  endif
  
  w = f;
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
  
  sumaXporY = 0;
  sumaX2porY = 0;
  sumaXporLogY = 0;
  sumaLogY = 0;
  sumaLogX = 0;
  sumaLogXporLogY = 0;
  sumaXporInvY = 0;
  sumaInvY = 0;
  
  p = rows(xs);
  M = [xs ys];
  M2 = M .* M;
  M3 = M .* M .* M;
  M4 = M .* M .* M .* M;
  
  sumaX = sum(M)(1,1);
  sumaY = sum(M)(1,2);
  sumaXcuadrado = sum(M2)(1,1);
  sumaXcubo = sum(M3)(1,1);
  sumaXcuarta = sum(M4)(1,1);
  sumaLogX2 = 0;
  
  for i = 1:p
    sumaXporY += M(i,1) * M(i,2);
    sumaX2porY += M(i,1)^2 * M(i,2);
    sumaXporLogY += M(i,1) * log(M(i,2));
    sumaLogY += log(M(i,2));
    sumaLogX += log(M(i,1));
    sumaLogX2 += (log(M(i,1))) ^ 2;
    sumaLogXporLogY += log(M(i,1)) * log(M(i,2));
    sumaXporInvY += M(i,1) * (1 / M(i,2));
    sumaInvY += 1 / M(i,2);
  endfor;
endfunction

function resolverFunciones(xs)
  lineal(xs);
  cuadratica(xs);
  exponencial(xs);
  potencial(xs);
  hiperbola(xs);
endfunction

%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%  Mat = [xs ys];
%  matriz = sprintf("%8.3f %8.3f\n", flip(rot90(Mat)));



%text(0.790,0.70, "Conjunto de puntos actuales", "fontsize", 14, "color", "black");
%text(0.840,0.60, "     X       Y\n-------------------", "fontsize", 14, "color", "black", "fontname", "Consolas");
%text(0.840,0.48, matriz, "fontsize", 14, "color", "black", "fontname", "Consolas");

%   btn_mostrar = uimenu("label", "Mostrar");
%   btn_mostrarPuntos = uimenu(btn_mostrar, "label", "Mostrar Puntos", "callback", "mostrarvalores(xs,ys)");
%   btn_verErrores = uimenu(btn_mostrar, "label", "Mostrar Errores", "callback", "mostrarError");


% , "backgroundcolor", "grey"

function main % Ventana de Bienvenido
  global h = figure("name", "Aproximación por Minimos Cuadrados", "position", [330,140,720,440], "graphicssmoothing", "on", "menubar", "none");
  box on;
  axis off; 
  integrantes = "- Joaquin Rodriguez\n- Laura Ferreri\n- Damian Javier Sanchez\n- Martín Bruno\n- Ezequiel Alonso";
  
  uicontrol("style", "text", "string", "Bienvenido a", "fontsize", 26, "position",[200 330 230 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "AMIC", "fontsize", 26, "foregroundcolor", "red", "position",[422 330 100 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "Integrantes, Grupo Mixto 9:", "fontsize", 14, "foregroundcolor", "blue", "position",[234 264 260 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", integrantes, "fontsize", 12, "foregroundcolor", "blue", "fontangle", "italic", "position",[264 156 200 110], "backgroundcolor", "white");
  uicontrol("string", "Comenzar", "position",[290 52 150 36], "callback", "comenzar");
endfunction

function comenzar % Empieza de cero ingresando los valores
  global h;
  global xs;
  global ys;
  
  close(h);
  
  global p;
  global xs;
  global ys;
  global decimales;
  p = 3;
  xs = [3;4;5];
  yx = [6;7;8];
  decimales = "4";
  
  %dlg_ingresarDatos;
  principal;
endfunction

function principal % Ventana Principal
  global h;
  global xs;
  global ys;
  
  h = figure("name", "Aproximación por Minimos Cuadrados", "position", [330,95,780,500], "graphicssmoothing", "on");
  calcularValores(xs, ys);
  resolverFunciones(xs);
  btn_ingresar = uimenu("label", "Ingresar");
    btn_conjuntosPuntos = uimenu(btn_ingresar, "label", "Nuevo Set de datos", "callback", "comenzar");

  btn_funciones = uimenu("label", "Funciones");
    btn_aproximacion_elegir = uimenu(btn_funciones, "label", "Aproximar Mediante:");
      btn_recta = uimenu(btn_aproximacion_elegir, "label", "Función Lineal", "callback", 'mostrarOpciones(xs,ys,"lineal")');
      btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Función Parabola", "callback", 'mostrarOpciones(xs,ys,"cuadratica")');
      btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Función Exponencial", "callback", 'mostrarOpciones(xs,ys,"exponencial")');
      btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Función Potencial", "callback", 'mostrarOpciones(xs,ys,"potencial")');
      btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Función Hipérbola", "callback", 'mostrarOpciones(xs,ys,"hiperbola")');

  btn_comparacion = uimenu("label", "Comparar Aproximaciones", "callback", "comparar");
  btn_salir = uimenu("label", "Salir", "callback", "salirPrograma");
endfunction

function dlg_ingresarDatos % Ingresar nuevo set de datos
  global xs;
  global ys;
  global p;
  global decimales;
  
  flag = false
  do
    puntos = inputdlg("Cuantos puntos (x,y) desea ingresar?");
    p = str2num(cell2mat(puntos));
    if (p > 1)
      flag = true;
    else
      errordlg("Ingreso una cantidad de valores menor a 2"); 
    endif
  until (flag);
  
  flag = false
  do
    valoresX = inputdlg("Ingresar el conjunto de x (Separados por punto y coma ';')");
    valoresX = cell2mat(valoresX);
    valoresX = cstrcat("[",valoresX,"]");
    xs = str2num(valoresX);
    if (rows(xs) == p)
      flag = true;
    else
      errordlg("Ingreso una cantidad de valores distinto de lo especificado");
    endif;
  until (flag);

  flag = false;
  do
    valoresY = inputdlg("Ingresar el conjunto de y (Separados por punto y coma ';')");
    valoresY = cell2mat(valoresY);
    valoresY = cstrcat("[",valoresY,"]");
    ys = str2num(valoresY);
    if (rows(ys) == p)
      flag = true;
    else
      errordlg("Ingreso una cantidad de valores distinto de lo especificado");
    endif;
  until (flag);
  
  dec = inputdlg("Ingrese la cantidad de decimales (redondeo) que se mostraran");
  decimales = cell2mat(dec);
endfunction

function salirPrograma
  global h;
  close(h);
endfunction

%% +++++++++++++++++++++++++++ MENU FUNCIONES ++++++++++++++++++++++++++++++



%******************************************************************************************


function mostrarOpciones(xs,ys,nombreFuncion)
	global h;
  global func;
  global xs;
  global ys;
  global p;
  global A;
  global B;
  global a2;
  global b2;
  global c2;
  
	clf;
  set(h, "name", cstrcat("Aproximación ", nombreFuncion));	
  set(h, "position", [330,95,780,560]);
  f = str2func(nombreFuncion);
  f(1);

  %% ++++++++++
	uicontrol("style", "text", "string", "Función aproximante:", "fontsize", 14, "position", [230 505 190 30], "backgroundcolor", "white");
	uicontrol("style", "text", "string", toupper(nombreFuncion), "fontsize", 14, "position", [430 505 128 30], "backgroundcolor", "white", "fontangle", "italic");
	
  panel = uipanel("title", "Cálculo", "position", [.15 .20 .7 .65]);%, "backgroundcolor", "white");
    uicontrol("parent", panel, "style", "text", "string", cstrcat("   X\n  -------\n",disp(xs)), "position", [10 30 66 330]);
    uicontrol("parent", panel, "style", "text", "string", cstrcat("   Y\n  -------\n",disp(ys)), "position", [70 30 66 330]);
    uicontrol("parent", panel, "style", "text", "string", cstrcat("  Matriz A\n",disp(A)), "position", [320 275 190 90]);
    uicontrol("parent", panel, "style", "text", "string", cstrcat("  Matriz B\n",disp(B)), "position", [320 175 190 90]);
    uicontrol("parent", panel, "style", "text", "string", "AX = B", "fontsize", 14, "position", [320 130 190 30]);

    uicontrol("parent", panel, "style", "text", "string", "=>", "fontsize", 18, "position", [340 62 40 50]);
    uicontrol("parent", panel, "style", "text", "string", cstrcat("a = ", disp(a2), "b = ", disp(b2)), "fontsize", 11, "position", [384 50 120 75]);
    
  uicontrol("style", "text", "string", func, "fontsize", 12, "position", [85 60 600 30]);
	
  switch nombreFuncion % Menu Graficar
    case "lineal"
      uimenu("label", "Graficar Función", "callback", "graficar(xs,ys,'lineal')");
    case "cuadratica"
      uimenu("label", "Graficar Función", "callback", "graficar(xs,ys,'cuadratica')");
      uicontrol("parent", panel, "style", "text", "string", cstrcat("a = ", disp(a2), "b = ", disp(b2), "c = ", disp(c2)), "fontsize", 11, "position", [384 50 120 75]);
    case "exponencial"
      uimenu("label", "Graficar Función", "callback", "graficar(xs,ys,'exponencial')");
    case "potencial"
      uimenu("label", "Graficar Función", "callback", "graficar(xs,ys,'potencial')");
    case "hiperbola"
      uimenu("label", "Graficar Función", "callback", "graficar(xs,ys,'hiperbola')");
  endswitch
  uimenu("label", "Volver a Menu Principal", "callback", "salir");
  
endfunction

function graficar(xs,ys,funcion)
  global func;
  global h;
  global a2;
  global b2;
  
  clf;
  set(h, 'Position', [330,100,780,530]);
  
  f = str2func(funcion);
  x = linspace(min(xs)-2, max(xs)+2);
    
  plot(x, f(x), xs, ys, "*r");
  xlabel("Eje x", 'Fontsize', 12);
  ylabel("Eje y", 'Fontsize', 12);
  title(cstrcat("Aproximación ", funcion), 'FontSize', 18, 'fontweight', "bold");
  
  switch funcion % Menu Graficar
    case "lineal"
      uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,'lineal')");
    case "cuadratica"
      uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,'cuadratica')");
    case "exponencial"
      uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,'exponencial')");
      k = sprintf("(%i*x)", a2);
      func = sprintf("f(x) = %i*e%s", b2, elevado(k));
    case "potencial"
      uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,'potencial')");
      k = sprintf("(%i)", a2);
      func = sprintf("f(x) = %i*x%s", b2, elevado(k));
    case "hiperbola"
      uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,'hiperbola')");
  endswitch
  
  legend(func);
endfunction

%% +++++++++++++++++++++++ COMPARACION DE FUNCIONES +++++++++++++++++++++++++

function salir
  global h;
  close(h);
  principal;
endfunction

function comparar
  global h;
  global xs;
  global ys;
  global error;
  global decimales;

  i = rows(xs);
  I = rot90(flip(1:i));
  yLineal = [];
  yCuadratica = [];
  yExponencial = [];
  yPotencial = [];
  yHiperbola = [];
  eLineal = [];
  eCuadratica = [];
  eExponencial = [];
  ePotencial = [];
  eHiperbola = [];
  
  for j = 1:i
    yLineal(j,1) = lineal(xs(j)); 
    eLineal(j,1) = redondeo(error,decimales);
    yCuadratica(j,1) = cuadratica(xs(j));
    eCuadratica(j,1) = redondeo(error,decimales);
    yExponencial(j,1) = exponencial(xs(j)); 
    eExponencial(j,1) = redondeo(error,decimales);
    yPotencial(j,1) = potencial(xs(j)); 
    ePotencial(j,1) = redondeo(error,decimales);
    yHiperbola(j,1) = hiperbola(xs(j));
    eHiperbola(j,1) = redondeo(error,decimales);
  endfor;
  
  M1 = [I xs ys yLineal yCuadratica yExponencial yPotencial yHiperbola];
  M2 = [I eLineal eCuadratica eExponencial ePotencial eHiperbola];
  
  clf;
  matriz1 = "      i         Xi       Yi       Mod.1     Mod.2     Mod.3     Mod.4     Mod.5     \n";
  matriz1 = cstrcat(matriz1, "   ===============================================================================     \n");
  matriz1 = cstrcat(matriz1, disp(M1));
  matriz2 = "      i       Err.1     Err.2     Err.3     Err.4     Err.5      \n";
  matriz2 = cstrcat(matriz2, "   ==============================================================     \n");
  matriz2 = cstrcat(matriz2, disp(M2));

  % "backgroundcolor", "white"
  set(h, "name", "Comparación de Funciones");
  set(h, "position", [330,90,780,600]);
  uimenu("label", "Volver", "callback", "salir");
  uicontrol("style", "text", "string", "Comparación de f(x)", "fontsize", 14, "position", [85 528 600 30], "backgroundcolor", "white");
  uicontrol("style", "text", "string", matriz1, "fontname", "Consolas", "position", [80 276 600 250], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "Error de f(x)", "fontsize", 14, "position", [85 252 600 30], "backgroundcolor", "white");
  uicontrol("style", "text", "string", matriz2, "fontname", "Consolas", "position", [80 0 600 250], "backgroundcolor", "white"); 
  menorError;
  
  %% Esto se muestra por Consola
  matriz = sprintf("[ %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f  ]\n", flip(rot90(M1)));
  printf("\n\n");
  printf("      i         X       Y       Mod.1    Mod.2    Mod.3    Mod.4    Mod.5    Err.1    Err.2    Err.3    Err.4    Err.5\n");
  printf("   ====================================================================================================================\n");
  disp(matriz);
endfunction

function menorError
  global error;
  global xs;
  global decimales;
  
  errLineal = 0;
  errCuadratica = 0;
  errExponencial = 0;
  errPotencial = 0;
  errHiperbola = 0;
  
  for i = 1:rows(xs)
    lineal(xs(i));
    errLineal += error;
    cuadratica(xs(i));
    errCuadratica += error;
    exponencial(xs(i));
    errExponencial += error;
    potencial(xs(i));
    errPotencial += error;
    hiperbola(xs(i));
    errHiperbola += error;
  endfor;
  
  errLineal = redondeo(errLineal,decimales);
  errCuadratica = redondeo(errCuadratica,decimales);
  errExponencial = redondeo(errExponencial,decimales);
  errPotencial = redondeo(errPotencial,decimales);
  errHiperbola = redondeo(errHiperbola,decimales);
  
  M = [ errLineal errCuadratica errExponencial errPotencial errHiperbola ];
  minim = find(M == min(M));

  result = "La(s) funcion(es) aproximantes con el minimo error son:\n";
  
  for i = 1:columns(minim)
    if (minim(i) == 1)
      disp("entre");
      result = cstrcat(result, "    * Lineal\n");
    endif;
    if (minim(i) == 2)
      result = cstrcat(result, "    * Cuadratica\n");
    endif;
    if (minim(i) == 3)
      result = cstrcat(result, "    * Exponencial\n");
    endif;
    if (minim(i) == 4)
      result = cstrcat(result, "    * Potencial\n");
    endif;
    if (minim(i) == 5)
      result = cstrcat(result, "    * Hiperbola\n");
    endif;    
  endfor;
  msgbox(result);
endfunction

main;