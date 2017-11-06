%pkg load control;
%pkg load signal;
clear

global x = [1 2 3 4];
global y = [5 10 20 50];


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
  
    btn_recta = uimenu(btn_aproximacion_elegir, "label", "Recta de mínimos cuadrados", "callback", "mincua(x,y,n)");
    
   % btn_recta = uimenu(btn_aproximacion_elegir, "label", "Recta de mínimos cuadrados", "callback", "show_recta");
    btn_parabola = uimenu(btn_aproximacion_elegir, "label", "Parábola de mínimos cuadrados", "callback", "show_parábola");
    btn_exponencial = uimenu(btn_aproximacion_elegir, "label", "Aproximación Exponencial", "callback", "show_exponencial");
    btn_potencial = uimenu(btn_aproximacion_elegir, "label", "Aproximación Potencial", "callback", "show_potencial");
    btn_hiperbola = uimenu(btn_aproximacion_elegir, "label", "Aproximación Hipérbola", "callback", "show_hiperbola");

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
  
  numero = inputdlg("Ingresar el orden del polinomio por el cual se desea aproximar");
  
  disp(numero);
  
  n = str2double(numero);
  
  drawnow ("expose");
   
endfunction


function mostrarvalores
  
  global n;
  
  msgbox(disp(n));
  
endfunction
