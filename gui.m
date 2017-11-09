clear

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

% Deshabilita los botones de menu que vienen por defecto
%f = figure("MenuBar","None");
calcularValores(xs,ys);
resolverFunciones(xs);

% Ventana Principal
global h = figure(1);
set(h, 'Position', [330,136,720,440], 'graphicssmoothing', "on");

integrantes = "Joaquin Rodriguez\nLaura Ferreri\nDamian Javier Sanchez\nMartín Bruno\nEzequiel Alonso";

Mat = [xs ys];
matriz = sprintf("%8.3f %8.3f\n", flip(rot90(Mat)));

box on;
axis off;
text(0.280,0.9, "Bienvenido a ", "fontsize", 30);
text(0.760,0.9, "AMIC", "fontsize", 30, "color", "red", "fontweight", "bold");
text(0.0,0.6, "Integrantes, Grupo Mixto 9:", "fontsize", 18, "color", "blue", "fontweight", "bold");
text(0.14,0.4, integrantes, "fontsize", 16, "color", "blue");
text(0.790,0.70, "Conjunto de puntos actuales", "fontsize", 14, "color", "black");
text(0.840,0.60, "     X       Y\n-------------------", "fontsize", 14, "color", "black", "fontname", "Consolas");
text(0.840,0.48, matriz, "fontsize", 14, "color", "black", "fontname", "Consolas");
refresh();



btn_ingresar = uimenu("label", "Ingresar");
  btn_conjuntosPuntos = uimenu(btn_ingresar, "label", "Conjunto de Puntos", "callback", "dlg_ingresar_conjuntosPuntos");
  btn_decimales = uimenu(btn_ingresar, "label", "Decimales (redondeo)", "callback", "dlg_ingresar_decimales");
  
btn_mostrar = uimenu("label", "Mostrar");
  btn_mostrarPuntos = uimenu(btn_mostrar, "label", "Mostrar Puntos", "callback", "mostrarvalores(xs,ys)");
  btn_verErrores = uimenu(btn_mostrar, "label", "Mostrar Errores", "callback", "mostrarError");
  
btn_funciones = uimenu("label", "Funciones");
  btn_aproximacion_elegir = uimenu(btn_funciones, "label", "Aproximar Mediante:");
    btn_recta = uimenu(btn_aproximacion_elegir, "label", "Función Recta", "callback", 'graficar(xs,ys,"lineal")');
    btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Función Parabola", "callback", 'graficar(xs,ys,"cuadratica")');
    btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Función Exponencial", "callback", 'graficar(xs,ys,"exponencial")');
    btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Función Potencial", "callback", 'graficar(xs,ys,"potencial")');
    btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Función Hipérbola", "callback", 'graficar(xs,ys,"hiperbola")');

btn_comparacion = uimenu("label", "Comparar Aproximaciones", "callback", "comparar");

btn_salir = uimenu("label", "Salir", "handlevisibility", "off", "callback", "close(gcf)");

function comparar
  global xs;
  global ys;
  global error;

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
    eLineal(j,1) = error;
  endfor;
  for j = 1:i
    yCuadratica(j,1) = cuadratica(xs(j));
    eCuadratica(j,1) = error;
  endfor;
  for j = 1:i
    yExponencial(j,1) = exponencial(xs(j)); 
    eExponencial(j,1) = error;
  endfor;
  for j = 1:i
    yPotencial(j,1) = potencial(xs(j)); 
    ePotencial(j,1) = error;
  endfor;
  for j = 1:i
    yHiperbola(j,1) = hiperbola(xs(j));
    eHiperbola(j,1) = error;
  endfor;
  
  M = [I xs ys yLineal yCuadratica yExponencial yPotencial yHiperbola eLineal eCuadratica eExponencial ePotencial eHiperbola];
  matriz = sprintf("[ %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f %8.3f  ]\n", flip(rot90(M)));
  printf("\n\n");
  printf("      i         X       Y       Mod.1    Mod.2    Mod.3    Mod.4    Mod.5    Err.1    Err.2    Err.3    Err.4    Err.5\n");
  printf("   ====================================================================================================================\n");
  disp(matriz);
  %msgbox(disp(M));
 endfunction

function mostrarBotones(xs,ys,nombreFunc)

	d = figure("MenuBar","None");
	
	gp = uibuttongroup (d, "Position", [ 0 0.9 1 1])

		b1 = uicontrol (gp, "string", "FunciÃ³n aproximante", "Position", [ 10 10 150 30 ], "callback", 'msgbox(func)'); %no es lo mejor pero es la forma que encontre
		b2 = uicontrol (gp, "string", "Detalle del cÃ¡lculo", "Position", [ 200 10 150 30 ], "callback", '-'); %aca iria la tabla
		b3 = uicontrol (gp, "string", "DistribuciÃ³n de puntos", "Position", [ 390 10 150 30 ], "callback", 'graficar(xs,ys,nombreFunc)'); %no esta tomando nombreFunc como "hiperbola"

endfunction
	
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
  
  figure(1);
  drawnow();
  calcularValores(xs,ys);
  resolverFunciones(xs);
endfunction

function dlg_ingresar_decimales
  global decimales;
  global xs;
  
  texto = "Ingrese la cantidad de decimales que se mostraran\nActualmente: ";
  texto = cstrcat(texto,decimales);
  aux = inputdlg(texto);
  decimales = num2str(aux{1,1});
  resolverFunciones(xs);
endfunction

function graficar(xs,ys,funcion)
  global func;
  global h;
  f = str2func(funcion);
  x = linspace(min(xs)-2, max(xs)+2);
    
  plot(x, f(x), xs, ys, "*r");
  set(h, 'Position', [314,150,732,520]);
  
  xlabel("Eje x", 'Fontsize', 12);
  ylabel("Eje y", 'Fontsize', 12);
  title(cstrcat("Aproximación ", funcion), 'FontSize', 18, 'fontweight', "bold");
  legend(func);
endfunction

function mostrarvalores(xs,ys)
  puntos = cstrcat("Conjunto de x = [ ", num2str(rot90(xs)), " ]\n", "Conjunto de y = [ ", num2str(rot90(ys)), " ]");
  msgbox(puntos, "Conjunto de Puntos");
endfunction
  
function mostrarError()
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
  
  msj = "Error de cada aproximaciÃ³n: \n\n";
  msj = cstrcat(msj, "lineal = ", disp(errLineal), "cuadratica = ", disp(errCuadratica));
  msj = cstrcat(msj, "exponencial = ", disp(errExponencial), "potencial = ", disp(errPotencial));
  msj = cstrcat(msj, "hiperbola = ", disp(errHiperbola));
  msgbox(disp(msj));
endfunction