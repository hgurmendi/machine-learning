# ml03

Fourth programming assignment for the Machine Learning course in Universidad
Nacional de Rosario.

## Assignment

[Programas y archivos necesarios](
https://sites.google.com/site/aprendizajeautomatizadounr/down_nb): Programa
base del clasificador bayesiano y ejemplos de archivos de configuraciones.

Trabajos a realizar:

1) Complete el programa nb_n.c (o haga uno propio) para aproximar p(a|C) por
una Gaussiana (a es un atributo y C una clase). El programa debe ajustar los
dos parámetros de la función (la media y la desviación estándar) en forma
independiente para cada clase y cada atributo. Entregue el programa.

2) Dimensionalidad: Repita el punto 7 del Práctico 1, usando el Clasificador
Bayesiano con Gaussianas del punto a). Genere una gráfica incluyendo también
los resultados de redes y árboles.

3) Límites del clasificador: Resuelva el problema de dos-elipses utilizando
el Clasificador Bayesiano con Gaussianas. Compare el resultado con el
obtenido con redes. Realice una gráfica de la predicción sobre el conjunto
de test. Resuelva el problema de las espirales-anidadas, y también compare
con el resultado de redes y realice la gráfica. Explique por qué se
obtienen esos resultados.

4) Modifique el programa nb_n.c de manera de aproximar ahora p(a|C) por la
frecuencia del atributo a en la clase C, es decir, construyendo histogramas.
La cantidad de bins que utilice para ello será un parámetro de entrada, que
deberá ser optimizado usando un conjunto de validación elegido al azar.
Implemente la corrección a la estimación de probabilidades indicada en el
punto 6.9.1.1, pág. 179 del libro de Mitchell (con p=1/m). Entregue el
programa modificado.
Revisite los problemas de dos-elipses y de espirales-anidadas, usando
conjuntos de validación adecuados. Haga un barrido conveniente sobre el
número de bins utilizados. Grafique el error porcentual de clasificación en
ajuste, validación y test en función de dicho número de bins (hay
sobreajuste?). Elija la cantidad óptima de bins y grafique las
clasificaciones en test. Compárelos con los resultados del punto c).

5) Opcional 1: Implemente una versión del clasificador Bayesiano con
histogramas donde los atributos no sean considerados independientes. Es
aceptable hacer un programa limitado a datasets de no más de 3 dimensiones.
Aplíquelo al problema de las espirales-anidadas, y compárelo con los
resultados anteriores. Discuta los problemas de implementación y de
aplicación práctica que tendría este algoritmo en datasets de muchas
dimensiones.

6) Opcional 2: Implemente el método de discretización recursiva por mínima
entropía discutida en el punto 3.3 del paper en el archivo adjunto debajo
en esta página. Entregue el programa. Aplíquelo al problema dos-elipses.
Interprete los resultados.

En todos los items del práctico discutir los puntos o resultados que considere conveniente. 

