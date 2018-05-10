# ml02

Third programming assignment for the Machine Learning course in Universidad
Nacional de Rosario.

## Assignment

[Programas y archivos necesarios](
https://sites.google.com/site/aprendizajeautomatizadounr/down_bp): Programa
de entrenamiento de redes neuronales y ejemplos de archivos de
configuraciones.


Problema de demostración: Reconocimiento de caras.
En la página de datasets hay una versión preprocesada y lista para usar del
archivo de imágenes para reconocimiento de caras que se discute en el libro
de Mitchell, pero con solamente dos clases (faces_lr). Baje el dataset y
entrene redes con diferentes arquitecturas para resolver el problema.
Grafique las curvas de error de entrenamiento y test, tanto las de mse como
las de error de clasificación. Compárelas. Busque indicios de
sobreentrenamiento.

Obs.: Para conseguir una convergencia más rápida en este problema, es
aconsejable llevar los inputs al rango [0:1] (por qué?). Esto se puede hacer,
por ejemplo, con una pequeña modificación a la función read_data() del bp.c.


*Trabajos a realizar:*

a) Mínimos locales: Baje el dataset dos-elipses de la página de datasets.
Cree el archivo .net necesario. Realice varios entrenamientos con los
siguientes parámetros: 6 neuronas en la capa intermedia, 500 patrones en el
training set, de los cuales 400 se usan para entrenar y 100 para validar el
modelo, 2000 patrones en el test set, 40000 épocas de entrenamiento, grabando
resultados cada 200 o 400 épocas. Pruebe distintos valores de momentum y
learning-rate (valores usuales son 0, 0.5, 0.9 para el momentum y 0.1, 0.01,
0.001 para el learning-rate, pero no hay por qué limitarse a esos valores),
para tratar de encontrar el mejor mínimo posible de la función error. Con
los parámetros dados, hay seguro soluciones entre 5% y 6% de error en test,
y tal vez mejores. Confeccione una tabla con los valores usados para los
parámetros y el resultado en test obtenido. Haga una gráfica de mse de train,
validación y test en función del número de épocas para los valores
seleccionados.

b) Arquitectura: Entrene redes neuronales para resolver el problema de
clasificación de las espirales anidadas. Use un número creciente de neuronas
en la capa intermedia: 2, 5, 10, 20, 40. Valores posibles para los demás
parámetros de entrenamiento: learning rate 0.01, momentum 0.5, 1600 datos
para ajustar los modelos, 400 para validar, 2000 para testear, 40000 épocas
de entrenamiento, grabando cada 400. Para cada uno de los cinco modelos
obtenidos, graficar en el plano xy las clasificaciones sobre el conjunto de
test (para 10 neuronas hay solución con error del orden de 22%, para 40 del
orden de 10%, el tiempo de ejecución puede llegar a 20 minutos).

c) Regularización: Baje el dataset Ikeda de la página de datasets. Realice
entrenamientos usando el 95% del archivo .data para entrenar, y el resto
para validar (todos los otros parámetros hay que mantenerlos como están en
el archivo .net original que viene con el dataset). Realice otros
entrenamientos cambiando la relación a 75%-25%, y a 50%-50%. En cada caso
seleccione un resultado que considere adecuado, y genere gráficas del mse
en train, validación y test.

d) Regularización: Modifique el programa bp.c para implementar otro método de
regularización, el weight-decay. Agregue un término de penalización a la
magnitud de los pesos en la función error (página 117, Mitchell), y la
modificación necesaria a su derivada. El parámetro gamma hay que agregarlo al
archivo de configuración. En lugar del error sobre el conjunto de validación,
en este caso es interesante analizar curvas del error de ajuste, del término
de penalización y del error en test en función del número de épocas.

Una vez implementado, aplíquelo al dataset Sunspots. Busque el valor de gamma
adecuado para conseguir un equilibrio entre evitar el sobreajuste y hacer el
modelo demasiado rígido (el valor de gamma se debe variar en varios órdenes
de magnitud, por ejemplo empezar en 10^-8 e ir hasta 10^0 (1) de a un orden
cada vez). En este caso todos los registros del archivo .data se deben usar
para el entrenamiento, ya que la regularización se realiza con la
penalización a los pesos grandes. Todos los otros parámetros se deben dejar
como en el archivo .net que viene con el dataset.

Entregue el programa modificado, y curvas de los tres errores para el valor
de gamma elegido, y para algún otro valor en que haya observado sobreajuste.

e) Dimensionalidad: Repita el punto 7 del Práctico 1, usando redes con 6
unidades en la capa intermedia. Genere una gráfica con los resultados de
redes y árboles.

OPCIONAL:

f) Multiclase: Extienda el programa bp.c para que pueda usarse para resolver
problemas de clasificación de más de dos clases. Explique el por qué, los
pros y los contras (si los hay) del método que eligió.

Baje de la página de datasets los archivos del problema iris y entrene una
red sobre ellos.

Entregue el programa (si hay modificaciones), una gráfica del mse en train,
validación y test, y otra del error de clasificación para los mismos
conjuntos, y el archivo con las predicciones sobre el conjunto de test
(.predic en el bp.c).

Baje el dataset Faces de la página de datasets (la versión que tiene 4
clases). Entrene una red neuronal para  resolver dicho problema. Compare
los resultados con los citados en Mitchell (pag. 112). Entregue el archivo
con las predicciones sobre el conjunto de test (.predic en el bp.c).
  
En todos los puntos del práctico discutir los resultados que considere
conveniente.

