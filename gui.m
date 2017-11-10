
clear


%% ++++++++++++++++++++++++ DEFINICI�N DE VARIABLES ++++++++++++++++++++++++++
global xs = [1; 2; 3];
global ys = [5; 10; 15];
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
global nombreFunc;

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
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  
  a2 = redondeo(a,"4");
  b2 = redondeo(b,"4");
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
  
  A = [ sumaXcuarta sumaXcubo sumaXcuadrado
        sumaXcubo sumaXcuadrado sumaX
        sumaXcuadrado sumaX p ];
  B = [ sumaX2porY ; sumaXporY ; sumaY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = X(2,1);
  c = X(3,1);
  
  a2 = redondeo(a,"4");
  b2 = redondeo(b,"4");
  c2 = redondeo(c,"4");
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
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  
  a2 = redondeo(a,"4");
  b2 = redondeo(b,"4");
  
  k = sprintf("(%i*x)", a2);
  func = sprintf("f(x) = %i*e%s", b2, elevado(k));
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
  
  A = [ sumaLogX2 sumaLogX ; sumaLogX p ];
  B = [ sumaLogXporLogY ; sumaLogY ];
  AI = inv(A);
  X = AI*B;
  a = X(1,1);
  b = exp(X(2,1));
  
  a2 = redondeo(a,"4");
  b2 = redondeo(b,"4");
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
  
  A = [ sumaXcuadrado sumaX ; sumaX p ];
  B = [ sumaXporInvY ; sumaInvY ];
  AI = inv(A);
  X = AI*B;
  a = 1 / X(1,1);
  b = a * X(2,1);
  
  a2 = redondeo(a,"4");
  b2 = redondeo(b,"4");
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
  global h = figure("name", "Aproximaci�n por Minimos Cuadrados", "position", [330,136,720,440], "graphicssmoothing", "on", "menubar", "none");
  box on;
  axis off; 
  integrantes = "- Joaquin Rodriguez\n- Laura Ferreri\n- Damian Javier Sanchez\n- Mart�n Bruno\n- Ezequiel Alonso";
  
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
  
  %global p;
  %global xs;
  %global ys;
  %global decimales;
  %p = 3;
  %xs = [3;4;5];
  %yx = [6;7;8];
  %decimales = "4";
  
  dlg_ingresarDatos;
  principal;
endfunction

function principal
  global h;
  global xs;
  global ys;
  
  h = figure("name", "Aproximaci�n por Minimos Cuadrados", "position", [330,136,780,500], "graphicssmoothing", "on");
  calcularValores(xs, ys);
  resolverFunciones(xs);
  btn_ingresar = uimenu("label", "Ingresar");
    btn_conjuntosPuntos = uimenu(btn_ingresar, "label", "Nuevo Set de datos", "callback", "comenzar");

  btn_funciones = uimenu("label", "Funciones");
    btn_aproximacion_elegir = uimenu(btn_funciones, "label", "Aproximar Mediante:");
      btn_recta = uimenu(btn_aproximacion_elegir, "label", "Funci�n Recta", "callback", 'mostrarOpciones(xs,ys,"lineal")');
      btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Funci�n Parabola", "callback", 'mostrarOpciones(xs,ys,"cuadratica")');
      btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Funci�n Exponencial", "callback", 'mostrarOpciones(xs,ys,"exponencial")');
      btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Funci�n Potencial", "callback", 'mostrarOpciones(xs,ys,"potencial")');
      btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Funci�n Hip�rbola", "callback", 'mostrarOpciones(xs,ys,"hiperbola")');

  btn_comparacion = uimenu("label", "Comparar Aproximaciones", "callback", "comparar");
  btn_salir = uimenu("label", "Salir", "callback", "salirPrograma");
endfunction

function dlg_ingresarDatos
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
  set(h, "name", "Comparaci�n de Funciones");
  set(h, "position", [330,136,780,600]);
  uimenu("label", "Volver", "callback", "salir");
  uicontrol("style", "text", "string", "Comparaci�n de f(x)", "fontsize", 14, "position", [85 528 600 30], "backgroundcolor", "white");
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

function graficar(xs,ys,funcion)
  global func;
  global h;
  
  clf;
  
  
  global nombreFunc;
  uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,nombreFunc)");
  
  
    
  f = str2func(funcion);
  x = linspace(min(xs)-2, max(xs)+2);
    
  plot(x, f(x), xs, ys, "*r");
  set(h, 'Position', [314,150,732,520]);
  xlabel("Eje x", 'Fontsize', 12);
  ylabel("Eje y", 'Fontsize', 12);
  title(cstrcat("Aproximaci�n ", funcion), 'FontSize', 18, 'fontweight', "bold");
  legend(func);
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


%******************************************************************************************

function salirPrograma
  global h;
  close(h);
endfunction

function mostrarOpciones(xs,ys,nombreFuncion)

	global h;
	
	global nombreFunc;
	
	clf;
	
  switch(nombreFuncion)
	case 'lineal'
		nombreFunc = sprintf("lineal");
	case 'cuadratica'
		nombreFunc = sprintf("cuadratica");
	case 'exponencial'
		nombreFunc = sprintf("exponencial");
	case 'potencial'
		nombreFunc = sprintf("potencial");
	case 'hiperbola'
		nombreFunc = sprintf("hiperbola");
	endswitch
  
	set(h, "name", "Seleccionar accion");
	set(h, "position", [314,150,732,520]);

	uicontrol("style", "text", "string", "Seleccionar opcion desde el menu", "fontsize", 14, "position", [85 350 600 30], "backgroundcolor", "white");
	uimenu("label", "Funcion aproximante", "callback", "mostrarFuncionAproximante");
	uimenu("label", "Detalle del calculo", "callback", "");
	uimenu("label", "Distribucion de puntos", "callback", "graficar(xs,ys,nombreFunc)");
	uimenu("label", "Volver a menu principal", "callback", "salir");
				
endfunction

function mostrarFuncionAproximante

	global nombreFunc;
	global func;
	global h;
	
	global xs;
	global ys;
	
	clf;

	set(h, "name", "Funcion aproximante");
	set(h, "position", [314,150,732,520]);
	
	uimenu("label", "Volver", "callback", "mostrarOpciones(xs,ys,nombreFunc)");

	uicontrol("style", "text", "string", "Funcion aproximante", "fontsize", 14, "position", [85 400 600 30], "backgroundcolor", "white");
	uicontrol("style", "text", "string", nombreFunc, "fontsize", 12, "position", [85 350 600 30], "backgroundcolor", "white");
	uicontrol("style", "text", "string", func, "fontsize", 12, "position", [85 300 600 30], "backgroundcolor", "white");
 
	
endfunction

	

main;