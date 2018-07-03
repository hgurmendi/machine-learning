# ml04

Fifth programming assignment for the Machine Learning course in Universidad
Nacional de Rosario.

## Assignment

a) Implemente el método de clasificación de _k-primeros-vecinos (k-nn)_. El
algoritmo debe buscar en los datos de entrenamiento los k patrones más
similares (según la métrica euclidea) al patrón que se quiere clasificar, y
asignar una clase a dicho patrón en función de una votación simple entre los
k-vecinos (qué decisión tomar en caso de empate queda a cargo del alumno).
El número k de vecinos a utilizar es el único parámetro libre del algoritmo,
y deberá ser optimizado utilizando un conjunto de validación. Las salidas
deben ser los errores de clasificación sobre los conjuntos de entrenamiento,
validación y test, y las predicciones sobre el conjunto de test. Se puede
utilizar como base el código del naive-Bayes del práctico 3.

b) Resuelva el problema de las _espirales-anidadas_ usando _k-nn_ con k fijo
e igual a 1 (clasificador de primer vecino). Realice una gráfica de la
predicción sobre el conjunto de test. Compare el resultado con el obtenido
con redes.

c) Dimensionalidad: Repita el punto 7 del Práctico 1, usando _k-nn_. Utilice
dos valores de k: el número de vecinos que se obtiene como mínimo de
validación, y 1 vecino. Genere una gráfica incluyendo también los resultados
de redes, árboles y naive-Bayes con Gaussianas.

d) Opcional 1: Otra variante de k-nn que se suele utilizar es usar en la
votación a todos los patrones que estén a una distancia menor a un dado valor
D del patrón que se quiere clasificar, en lugar de usar un número fijo k. El
único parámetro del  algoritmo, ahora, es la distancia máxima D, la que se
optimiza utilizando un conjunto de validación.

Implemente dicho algoritmo. Aplíquelo al problema de Dimensionalidad, y
compare el resultado con el obtenido en el punto c).

e) Opcional 2: Hay overffiting en k-nn? Puede encontrar algún ejemplo real o
artificial de un problema en el que la elección del valor óptimo de k mirando
el conjunto de entrenamiento (sin contar el mismo punto que se ajusta) lleve
a sobreajuste? Discuta el problema y los datos propuestos. 

Entregue los códigos implementados. Discuta los puntos o resultados que
considere conveniente. 

