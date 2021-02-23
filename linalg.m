#!/usr/bin/octave-cli

## Cargue los datos en del archivo 'escazu'.dat
D=load("escazu.dat");

## Extraiga la columna de áreas y precios
Xo=[ones(rows(D),1), D(:,1)];  ## áreas
Yo=D(:,4);                     ## precios

## Extraiga min-max de áreas y precios
minArea=min(Xo(:,2));
maxArea=max(Xo(:,2));
minPrice=min(Yo);
maxPrice=max(Yo);

## Use las ecuaciones normales para calcular los parámetros de
## regresión lineal
## theta=inv(Xo'*Xo)*Xo'*Yo;
theta=pinv(Xo)*Yo;

## Grafique los puntos originales y la recta de regresión lineal con
## al menos 100 puntos
figure(1,"name","Regresión lineal");

hold off;
plot(Xo(:,2),Yo,'bx'); ## Datos originales

areas=linspace(minArea,maxArea,100);
Xp=[ones(length(areas),1), areas'];  ## áreas
y=Xp*theta;

hold on;
plot(areas,y,'r',"linewidth",3);

## ¿Como podemos modificar esto para normalizar?

## ¿Cómo podemos modificar lo anterior para hacer una regresión
## polinomial?


