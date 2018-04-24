# ml01

Second programming assignment for the Machine Learning course in Universidad
Nacional de Rosario.

## Assignment

Trabajo Práctico 1: Arboles de decisión.

Trabajos previos:

1. Instale el C4.5 en su máquina. En el siguiente link hay archivos
modificados del c4.5 (con instrucciones de instalación) que se necesitan para
el trabajo. Explore el siguiente Tutorial en C4.5 (de la U. de Regina,
Canada, sitio original).

2. Para comenzar a utilizar el programa, analice el ejemplo play-tennis que
se discute en el libro. En la página de datasets están disponibles los datos
correspondientes. Verifique el árbol resultante con el presentado en la
página 53 del libro. Cambie el nivel de verbosity para poder controlar los
valores de entropía e information-gain en los nodos con los cálculos que se
muestran en las pag. 59 a 61 del libro.

3. Baje de la página de datasets los archivos correspondientes al problema
Iris. Obtenga un árbol de decisión y un conjunto de reglas a partir de los
datos. Analice los resultados.

Baje de la página de datasets los archivos correspondientes al problema
Hypothyroid. Obtenga un árbol de decisión y un conjunto de reglas a partir de
los datos. Analice los resultados.

Una de las virtudes de los árboles, por la que son frecuentemente usados en
problemas médicos, es que son "entendibles" en sus decisiones. Esto se aplica
a este problema?


Para Entregar:

4. Genere tres conjuntos de datos de entrenamiento correspondientes al
problema de las espirales anidadas de la práctica 0, uno de longitud 150, otro
de 600 y un tercero de 3000. Genere un conjunto de test de longitud 10000.
Cree el archivo .names necesario para el problema. A partir de cada uno de los
conjuntos de entrenamiento, desarrolle el árbol de decisión correspondiente y
grafique las predicciones sobre el conjunto de test (archivo .prediction).
Comente los resultados.


5. Dependencia con la longitud del conjunto de entrenamiento - Sobreajuste y
prunning:

Genere datasets usando el programa desarrollado en el punto a) de la práctica
0 (vamos a llamar a estos datos "diagonal", y a los descriptos en el punto b)
"paralelo"), con C = 0.78 y d = 2. Genere un único conjunto de test con
n = 10000, y cree el archivo .names necesario. Genere 20 conjuntos de
entrenamiento para cada uno de los siguientes valores de n: 125, 250, 500,
1000, 2000, 4000.  Corra el c4.5 sobre estos datos, y con los resultados
obtenidos genere dos pares de gráficas: en el primer par, usando los
resultados "before prunning", la primer gráfica tiene el training error y
test error (porcentuales), y la segunda la cantidad de nodos en el árbol,
todos como función de la longitud del conjunto de entrenamiento (utilice
siempre el promedio de los 20 conjuntos de cada longitud dada). En el segundo
par de gráficas repita el proceso para los resultados "after prunning".
Finalmente, repita todo el procedimiento completo usando como generador de
datos el "paralelo". Incluya los resultados correspondientes en las mismas
graficas del diagonal. Discuta brevemente los resultados.

6. Resistencia al ruido:
Genere datasets con d = 5, n = 250 para el conjunto de entrenamiento y
n = 10000 para el de test, variando el valor de C (overlapping de las clases)
de 0.5 a 2.5 con incrementos de 0.5. Como en el punto 5, para cada valor dado
de C cree 20 conjuntos distintos de entrenamiento, pero uno solo de test.
Genere una gráfica del test-error porcentual en función de C para el problema
"paralelo" y el "diagonal" (sólo los promedios de los 20 conjuntos para cada
valor de C, los resultados de los dos problemas en la misma gráfica). Tambien
incluya en la gráfica los valores mínimos que se piden en el opcional 6.1 (el
que no haga el opcional me los puede pedir por mail). Discuta los resultados.

6.1 Opcional:
Puede calcular para cada valor de C cuál es el mínimo error que se puede
conseguir? Cómo se comparan dichos valores con los obtenidos con el c4.5?
Obtenga una curva de error mínimo y agréguela a la gráfica anterior.
Hay varias maneras de hacerlo. Una simple es imaginando cual es el
clasificador ideal o de mínimo error para este problema (a ese clasificador
se lo llama "clasificador de Bayes") y midiendo directamente sobre un
conjunto de test grande (10000 puntos para d=5) cuántos puntos son mal
clasificados por ese clasificador ideal.

7. Dimensionalidad:
Genere datasets con C = 0.78, n = 250 para el conjunto de entrenamiento y
n = 10000 para el de test, variando esta vez el valor de d según la siguiente
lista: 2, 4, 8, 16, 32. Para cada valor de d cree 20 conjuntos distintos de
entrenamiento, y uno solo de test. Genere una gráfica del train y test error
porcentual en función de d para el problema "paralelo" y el "diagonal" (todos
en la misma gráfica). Discuta los resultados.

8. Opcional:  Baje de la página de datasets los archivos correspondientes al
problema XOR. Grafique las clases. Observando el problema, indique cuál es el
árbol más simple que clasifica correctamente todos los puntos. Aplique ahora
el c4.5 a este problema, y explique el resultado obtenido.
 
No hay que entregar nada de los puntos 1 a 3. Del resto, solamente las
gráficas y discusiones pedidas. 

Recomendación: guarden todos los resultados parciales que se usan para hacer
las figuras ya que se usan en los próximos prácticos como comparación

