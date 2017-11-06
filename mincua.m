% Sea t el vector con Dim 1xN que representa los puntos sobre el eje X
% Sea y el vector con Dim 1xN que represente los puntos sobre el eje Y
% Se desea encontrar una recta y = C.t + D que se aproxime a los puntos (X,Y) citados
% A su vez, conocer el Error de Aproximacion
function w=mincua(t,y,n)
  
    %Armo la matriz A la cual contiene en la primera columna los valores de t, mientras que en la segunda son todos "1"
    for i=(n+1):-1:1
        A(:,n+2-i)=[t.^(i-1)]';
    endfor
    
    B=A'; %B es las traspuesta de A
    M=B*A;
    MI=inv(M);%MI es la Matriz Inversa de M (si tiene)
    x0=MI*B*y';%x0 es el vector que contiene los coeficientes C y D de la recta
    
    ec=fopen("yy.m","w");
    
    fprintf(ec,"yy=");
    printf("p(x)=");
    
    for i=1:(n+1)
        printf("%+fx^%i",x0(i),n+1-i);
        fprintf(ec,"%+f.*x.^%i",x0(i),n+1-i);
    endfor
    
    printf("\n");
    fprintf(ec,";");
    fclose(ec);
    
    x=linspace(min(t)-2,max(t)+2,1000);
    yy
    
    f2 = figure(2);
    
    plot (x,yy,t,y,"*r");
    w=x0;
endfunction
    
    
    
