# ml00

First programming assignment for the Machine Learning course in Universidad
Nacional de Rosario.

## Assignment

Trabajo Práctico 0: Generación de datasets artificiales

Prepare programas en C que generen conjuntos de datos ( de longitud dada n )
de acuerdo a las siguientes descripciones:

a) Los datos tienen d inputs, todos valores reales, correspondientes a la
posición del punto en un espacio d-dimensional. El output es binario, y
corresponde a la clase a la que pertenece el ejemplo. La clase 1 corresponde
a puntos generados al azar, provenientes de una distribución normal, con
centro en el ( 1, 1, 1, .... , 1 ) y matriz de covarianza diagonal, con
desviación estándar igual a C * SQRT(d). La clase 0 tiene la misma
distribución, pero centrada en el ( -1, -1, -1, .... , -1 ). Los parámetros
que se deben ingresar son d y n (enteros) y C (real). De los n puntos
generados, n/2 deben pertenecer a cada clase.

Ayuda: Como la matriz de covarianza es diagonal, cada componente de los
inputs se puede generar de manera independiente, tomada de una normal con la
media y desviación estándar correspondientes.

b) Igual al punto anterior, pero las distribuciones tienen centro en el
( 1, 0, 0, .... , 0 ) y en el ( -1, 0, 0, .... , 0 ), respectivamente y la
desviación estandar es igual a C independientemente de d.

c) Espirales anidadas: Los datos tienen 2 inputs, x e y, que corresponden a
puntos generados al azar con una distribución UNIFORME (en dicho sistema de
referencia x-y)  dentro de un circulo de radio 1. El output es binario, 
correspondiendo la clase 0 a los puntos que se encuentran entre las curvas
ro = theta/4pi y ro = (theta + pi)/4pi (en polares) y la clase 1 al resto.
De los n puntos generados, n/2 deben pertenecer a cada clase. La siguiente
figura es un ejemplo:

https://sites.google.com/site/aprendizajeautomatizadounr/Inicio/practicos/tp0/espirales.jpg?attredirects=0

Para verificar los problemas a) y b), genere conjuntos con d=2, n=200 y
C=0.75, y grafíquelos. También genere conjuntos con d=4, n=2000 y C=2.00,
y verifique (usando por ejemplo una planilla de cálculo) que las medias y
desviaciones estándar sean correctas.

Para el problema c), genere un gráfico y compárelo con el que está arriba.

Todos los archivos generados tienen que respetar el formato c4.5, como se lo
describe en el manual del mismo (ver en tutorial ). La semilla de la función
rand() debe ser fijada con el reloj de la maquina.
 
 Cada alumno deberá entregar (por e-mail, en un archivo comprimido):

 - Todos los programas (en código C) que generan los datasets.
 - Un archivo de ejemplo de cada dataset 
