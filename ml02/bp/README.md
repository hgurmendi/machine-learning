# Stochastic Backpropagation

El archivo **bp.c** contiene el codigo C del algoritmo de entrenamiento de
Redes Neuronales usando Back-Propagation Estocástico. El código se puede
compilar en prácticamente cualquier sistema operativo de los comunmente
accesibles.

El programa utiliza el formato de datos del c4.5, pero en vez de un archivo
dataset.names busca un archivo de configuración dataset.net, que contiene
los parámetros necesarios para el entrenamiento. Al principio del programa,
y también en el archivo de ejemplo que se puede descargar de esta página,
se pueden encontrar detalles de qué es cada parámetro. El programa entrega
como salida un archivo con lospesos de la red entrenada, que tiene la forma
n.wts (donde n es un valor entero), un archivo con la evolución del error en
función de las épocas de entrenamiento (con la extensión .mse), y un archivo
con las predicciones sobre el conjunto de test (con la extensión .predic).

El archivo mse contiene los siguientes valores:

+ Columna 1: Error cuadrático medio (mse) estocástico sobre el conjunto de
train. Este es el valor que realmente se minimiza en cada época de
entrenamiento.
+ Columna 2: Mse medido sobre todo el conjunto de entrenamiento al finalizar
la época dada.
+ Columna 3: Mse medido sobre todo el conjunto de validación (si lo hay) al
finalizar la época dada.
+ Columna 4: Mse medido sobre todo el conjunto de test (si lo hay) al
finalizar la época dada.
+ Columna 5: Error de clasificación (porcentaje de puntos mal clasificados) 
medido sobre todo el conjunto de entrenamiento al finalizar la época dada.
+ Columna 6: Error de clasificación  medido sobre todo el conjunto de
validación (si lo hay) al finalizar la época dada.
+ Columna 7: Error de clasificación  medido sobre todo el conjunto de test
(si lo hay) al finalizar la época dada.

El archivo **discretiza.c** contiene el codigo C de un algoritmo que
discretiza la predicción de la red sobre los datos de test (o sea el archivo
.predic), convirtiendola en 0 o 1, de acuerdo a si es > o < que 0.5. El
archivo de salida tiene la extension .d. El archivo **separa_clases.c**
contiene el codigo C de un algoritmo que separa el archivo .predic en dos
nuevos archivos que continen los puntos que la red predice como de clase 0
(file_name.0) o de clase 1 (file_name.1).

Estos dos programas pueden ser útiles para graficar las predicciones.

El archivo **synth.net** es un ejemplo del archivo de configuración necesario
para ejecutar el bp. Lo que está despues del listado de parámetros (las
descripciones y comentarios) no es leído por el bp, por lo que no es
necesario borrarlo para ejecutar el programa.

