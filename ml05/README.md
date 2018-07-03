# ml05

Final programming assignment for the Machine Learning course in Universidad
Nacional de Rosario.

## Assignment

Trabajos a realizar:

a) Busque una implementación (puede ser cualquiera disponible en la web) del
método de _Support Vector Machines_. Utilícela para clasificar el 
[https://sites.google.com/site/aprendizajeautomatizadounr/Inicio/datasets](
dataset de Heladas), tanto en la versión lineal como usando un kernel
no-lineal a elección. También aplique los métodos de naive-bayes con normales
y árboles de decisión al mismo dataset. Evalúe los métodos con una estimación
en 10-Folds. Para ello divida el conjunto de entrenamiento en 10
subconjuntos, respetando la proporción original de puntos de cada clase, y
utilice alternativamente 9 de ellos para ajustar los métodos y el restante
para testear. Cuando sea necesario (por ejemplo, valor de C de las SVM),
optimice los parametros del método utilizado sobre una partición cualquiera
de las 10 generadas, y luego aplique para los demás casos los mismos valores.
Especifique en el informe qué procedimiento realizó para optimizarlos, y el
resultado obtenido. Genere un cuadro con las medias y desviaciones estándar
de los resultados en test de cada método.

b) Realice un t-test con 95% de confidencia (sección 5.6, p.145 del Mitchell)
entre el método que muestra el "mejor" resultado y el que muestra el "peor".
Realice un segundo test entre el que muestra el "mejor" resultado y el
"segundo mejor". ¿Hay resultado positivo en algún caso? ¿Qué conclusiones
puede extraer? (el valor correspondiente en la tabla 5.6 para 95% y 9 grados
de libertad es 2.26).

Entregue un informe con todos los detalles, análisis y explicaciones que
considere necesarias.

