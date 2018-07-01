/*
nb_n.c : Clasificador Naive Bayes usando la aproximacion de funciones normales para features continuos
Formato de datos: c4.5
La clase a predecir tiene que ser un numero comenzando de 0: por ejemplo, para 3 clases, las clases deben ser 0,1,2

PMG - Ultima revision: 20/06/2001
*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>

#define LOW 1.e-14      /*Minimo valor posible para una probabilidad */
#define PI  3.141592653

int N_IN;           /*Total numbre of inputs */
int N_Class;            /*Total number of classes (outputs) */

int PTOT;           /* cantidad TOTAL de patrones en el archivo .data */
int PR;             /* cantidad de patrones de ENTRENAMIENTO */
int PTEST;          /* cantidad de patrones de TEST (archivo .test) */
            /* cantidad de patrones de VALIDACION: PTOT - PR */

int SEED;           /* semilla para la funcion rand(). Los posibles valores son: */
            /* SEED: -1: No mezclar los patrones: usar los primeros PR para entrenar
               y el resto para validar.Toma la semilla del rand con el reloj.
               0: Seleccionar semilla con el reloj, y mezclar los patrones.
               >0: Usa el numero leido como semilla, y mezcla los patrones. */

int CONTROL;            /* nivel de verbosity: 0 -> solo resumen, 1 -> 0 + pesos, 2 -> 1 + datos */

int N_TOTAL;            /*Numero de patrones a usar durante el entrenamiento */

int K;                  /* Numero de vecinos */
/*matrices globales  DECLARAR ACA LAS MATRICES NECESARIAS */

double **data;          /* train data */
double **test;          /* test  data */
int *pred;          /* clases predichas */

int *seq;           /* sequencia de presentacion de los patrones */

/*variables globales auxiliares*/
char filepat[100];
/*bandera de error*/
int error;

/* guarda datos sobre los vecinos */
typedef struct _tuple {
    int class;
    double dist;
} tuple;

/* imprime un vector v de n doubles */
void print_vector(double *v, int n)
{
    int i;

    printf("(%lf", v[0]);
    for (i = 1; i < n; i++) {
        printf(", %lf", v[i]);
    }
    printf(")");
}

/* función comparación entre datos del tipo tuple */
/* se comparan los miembros dist */
int tuple_compare(const void *a, const void *b)
{
    tuple _a = *(tuple *) a;
    tuple _b = *(tuple *) b;

    int ret =123981293;

    if (_a.dist < _b.dist) {
        ret = -1;
    } else if (_a.dist > _b.dist) {
        ret = 1;
    } else {
        ret = 0;
    }

    return ret;
}

/* distancia euclídea entre los vectores a y b, ambos de n doubles */
double distance(double *a, double *b, int n)
{
    int i;
    double acum;

    acum = 0.;

    assert(n != 0);
    for (i = 0; i < n; i++) {
        acum += (a[i] - b[i]) * (a[i] - b[i]);
    }

    return sqrt(acum);
}

/* -------------------------------------------------------------------------- */
/*define_matrix: reserva espacio en memoria para todas las matrices declaradas.
  Todas las dimensiones son leidas del archivo .nb en la funcion arquitec()  */
/* -------------------------------------------------------------------------- */
int define_matrix()
{

    int i, max;
    if (PTOT > PTEST)
        max = PTOT;
    else
        max = PTEST;

    seq = (int *)calloc(max, sizeof(int));
    pred = (int *)calloc(max, sizeof(int));
    if (seq == NULL || pred == NULL)
        return 1;

    data = (double **)calloc(PTOT, sizeof(double *));
    if (PTEST)
        test = (double **)calloc(PTEST, sizeof(double *));
    if (data == NULL || (PTEST && test == NULL))
        return 1;

    for (i = 0; i < PTOT; i++) {
        data[i] = (double *)calloc(N_IN + 1, sizeof(double));
        if (data[i] == NULL)
            return 1;
    }
    for (i = 0; i < PTEST; i++) {
        test[i] = (double *)calloc(N_IN + 1, sizeof(double));
        if (test[i] == NULL)
            return 1;
    }

    return 0;
}

/* ---------------------------------------------------------------------------------- */
/*arquitec: Lee el archivo .nb e inicializa el algoritmo en funcion de los valores leidos
  filename es el nombre del archivo .nb (sin la extension) */
/* ---------------------------------------------------------------------------------- */
int arquitec(char *filename)
{
    FILE *b;
    time_t t;

    /*Paso 1:leer el archivo con la configuracion */
    sprintf(filepat, "%s.knn", filename);
    b = fopen(filepat, "r");
    error = (b == NULL);
    if (error) {
        printf("Error al abrir el archivo de parametros\n");
        return 1;
    }

    /* Dimensiones */
    fscanf(b, "%d", &N_IN);
    fscanf(b, "%d", &N_Class);

    /* Archivo de patrones: datos para train y para validacion */
    fscanf(b, "%d", &PTOT);
    fscanf(b, "%d", &PR);
    fscanf(b, "%d", &PTEST);

    /* Semilla para la funcion rand() */
    fscanf(b, "%d", &SEED);

    /* Nivel de verbosity */
    fscanf(b, "%d", &CONTROL);

    /* Cantidad de vecinos */
    fscanf(b, "%d", &K);

    fclose(b);

    /*Paso 2: Definir matrices para datos y parametros (e inicializarlos */
    error = define_matrix();
    if (error) {
        printf("Error en la definicion de matrices\n");
        return 1;
    }

    /* Chequear semilla para la funcion rand() */
    if (SEED == 0)
        SEED = time(&t);

    /*Imprimir control por pantalla */
    printf
        ("\nK-nearby neighbours:\nCantidad de entradas:%d",
         N_IN);
    printf("\nCantidad de clases:%d", N_Class);
    printf("\nArchivo de patrones: %s", filename);
    printf("\nCantidad total de patrones: %d", PTOT);
    printf("\nCantidad de patrones de entrenamiento: %d", PR);
    printf("\nCantidad de patrones de validacion: %d", PTOT - PR);
    printf("\nCantidad de patrones de test: %d", PTEST);
    printf("\nSemilla para la funcion rand(): %d", SEED);
    printf("\nCantidad de vecinos: %d\n", K);
    printf("Si K=0 se entrena variando K de 1 a PR/4.\n");

    return 0;
}

/* -------------------------------------------------------------------------------------- */
/*read_data: lee los datos de los archivos de entrenamiento(.data) y test(.test)
  filename es el nombre de los archivos (sin extension)
  La cantidad de datos y la estructura de los archivos fue leida en la funcion arquitec()
  Los registros en el archivo pueden estar separados por blancos ( o tab ) o por comas    */
/* -------------------------------------------------------------------------------------- */
int read_data(char *filename)
{

    FILE *fpat;
    double valor;
    int i, k, separador;

    sprintf(filepat, "%s.data", filename);
    fpat = fopen(filepat, "r");
    error = (fpat == NULL);
    if (error) {
        printf("Error al abrir el archivo de datos\n");
        return 1;
    }

    if (CONTROL > 1)
        printf("\n\nDatos de entrenamiento:");

    for (k = 0; k < PTOT; k++) {
        if (CONTROL > 1)
            printf("\nP%d:\t", k);
        for (i = 0; i < N_IN + 1; i++) {
            fscanf(fpat, "%lf", &valor);
            data[k][i] = valor;
            if (CONTROL > 1)
                printf("%lf\t", data[k][i]);
            separador = getc(fpat);
            if (separador != ',')
                ungetc(separador, fpat);
        }
    }
    fclose(fpat);

    if (!PTEST)
        return 0;

    sprintf(filepat, "%s.test", filename);
    fpat = fopen(filepat, "r");
    error = (fpat == NULL);
    if (error) {
        printf("Error al abrir el archivo de test\n");
        return 1;
    }

    if (CONTROL > 1)
        printf("\n\nDatos de test:");

    for (k = 0; k < PTEST; k++) {
        if (CONTROL > 1)
            printf("\nP%d:\t", k);
        for (i = 0; i < N_IN + 1; i++) {
            fscanf(fpat, "%lf", &valor);
            test[k][i] = valor;
            if (CONTROL > 1)
                printf("%lf\t", test[k][i]);
            separador = getc(fpat);
            if (separador != ',')
                ungetc(separador, fpat);
        }
    }
    fclose(fpat);

    return 0;

}

/* ------------------------------------------------------------ */
/* shuffle: mezcla el vector seq al azar.
   El vector seq es un indice para acceder a los patrones.
   Los patrones mezclados van desde seq[0] hasta seq[hasta-1]
   Esto permite separar la parte de validacion de la de train   */
/* ------------------------------------------------------------ */
void shuffle(int hasta)
{
    double x;
    int tmp;
    int top, select;

    top = hasta - 1;
    while (top > 0) {
        x = (double)rand();
        x /= RAND_MAX;
        x *= (top + 1);
        select = (int)x;
        tmp = seq[top];
        seq[top] = seq[select];
        seq[select] = tmp;
        top--;
    }
    if (CONTROL > 3) {
        printf("End shuffle\n");
        fflush(NULL);
    }
}

/* Calcula la clase más común entre los K vecinos más cercanos. */
int most_common_class(tuple *neighbours)
{
    int i, class;
    tuple *class_count = NULL;

    class_count = (tuple *) calloc(N_Class, sizeof(tuple));
    if (class_count == NULL) {
        fprintf(stderr, "Error inicializando memoria para class_count.\n");
        exit(1);
    }
    
    // Inicializo el contador de ocurrencias de cada clase en 0
    for (i = 0; i < N_Class; i++) {
        class_count[i].class = i;
        class_count[i].dist = 0.;
    }

    // Cuento las ocurrencias de cada clase dentro de los K vecinos.
    for (i = 0; i < K; i++) {
        class_count[neighbours[i].class].dist += 1.;
    }

    // Ordeno de menor a mayor las ocurrencias de las clases...
    qsort(class_count, N_Class, sizeof(tuple), tuple_compare);

    // ... con lo cual la mas ocurrente queda en el ultimo elemento.
    class = class_count[N_Class - 1].class;

    free(class_count);

    return class;
}

/* ------------------------------------------------------------------------------ */
/* Devuelve la clase de la mayoría de los K vecinos más cercanos al input.        */
/* ------------------------------------------------------------------------------ */
int output(double *input, int is_training_set)
{
    int i, nu, class;

    /* neighbours es un arreglo unidimensional de tuplas (clase, distancia) de los puntos del conjunto
    de entrenamiento al punto que se quiere clasificar. */
    tuple *neighbours = NULL;
    neighbours = (tuple *) calloc(PR, sizeof(tuple));
    if (neighbours == NULL) {
        fprintf(stderr, "Error reservando memoria para neighbours.\n");
        exit(1);
    }

    for (i = 0; i < PR; i++) {
        nu = seq[i];
        neighbours[i].dist = distance(input, data[nu], N_IN);
        /* Preguntar sobre esto: deberíamos considerar el vecino que es el mismo punto? */
        if (is_training_set && neighbours[i].dist == 0) {
            neighbours[i].dist = 1e10;
        }
        neighbours[i].class = data[nu][N_IN];
    }

    qsort(neighbours, PR, sizeof(tuple), tuple_compare);

    class = most_common_class(neighbours);

    free(neighbours);

    return class;
}

/* ------------------------------------------------------------------------------ */
/*propagar: calcula las clases predichas para un conjunto de datos
  la matriz S tiene que tener el formato adecuado ( definido en arquitec() )
  pat_ini y pat_fin son los extremos a tomar en la matriz
  usar_seq define si se accede a los datos directamente o a travez del indice seq
  los resultados (las propagaciones) se guardan en la matriz seq                  */
/* ------------------------------------------------------------------------------ */
double propagar(double **S, int pat_ini, int pat_fin, int usar_seq, int is_training_set)
{
	double mse = 0.0;
	int nu;
	int patron;

	for (patron = pat_ini; patron < pat_fin; patron++) {

		/*nu tiene el numero del patron que se va a presentar */
		if (usar_seq)
			nu = seq[patron];
		else
			nu = patron;

		pred[nu] = output(S[nu], is_training_set);

		/*actualizar error */
		if (S[nu][N_IN] != (double)pred[nu])
			mse += 1.;
	}

	mse /= ((double) (pat_fin - pat_ini));

	return mse;
}

/* --------------------------------------------------------------------------------------- */
/*train: ajusta los parametros del algoritmo a los datos de entrenamiento
         guarda los parametros en un archivo de control
         calcula porcentaje de error en ajuste y test                                      */
/* --------------------------------------------------------------------------------------- */
int train(char *filename)
{

    int i, k;
    int start_k, end_k;
    int min_valid_k;
    double min_valid_err, min_validtest_err;
    double train_error, valid_error, test_error;
    FILE *fpredic;

    /*Asigno todos los patrones del .data como entrenamiento porque este metodo no requiere validacion */
    //N_TOTAL = PTOT;
    N_TOTAL=PR; 
    for (k = 0; k < PTOT; k++)
        seq[k] = k; /* inicializacion del indice de acceso a los datos */

    /*efectuar shuffle inicial de los datos de entrenamiento si SEED != -1 (y hay validacion) */
    if (SEED > -1 && N_TOTAL < PTOT) {
        srand((unsigned)SEED);
        shuffle(PTOT);
    }


    if (K == 0) {
        start_k = 1;
        end_k = PR / 4;
    } else {
        start_k = K;
        end_k = K + 1;
    }

    sprintf(filepat, "%s.errors", filename);
    fpredic = fopen(filepat, "w");
    error = (fpredic == NULL);
    if (error) {
        printf("Error al abrir archivo para guardar errores\n");
        return 1;
    }

    /* Table header */
    fprintf(fpredic, "K,Train,Validation,Test\n");

    min_valid_k = -1;
    min_valid_err = 1e10;
    min_validtest_err = 1e10;

    for (K = start_k; K < end_k; K++) {
        printf("*** Entrenando con K = %d\n", K);

        train_error = propagar(data, 0, PR, 1, 1);
    
        /*calcular error de validacion; si no hay, usar mse_train */
        if (PR == PTOT) {
            valid_error = train_error;
        } else {
            valid_error = propagar(data, PR, PTOT, 1, 1);
        }
    
        /*calcular error de test (si hay) */
        if (PTEST > 0) {
            test_error = propagar(test, 0, PTEST, 0, 0);
        } else {
            test_error = 0.;
        }
        
        train_error *= 100.;
        valid_error *= 100.;
        test_error *= 100.;

        if (valid_error < min_valid_err) {
            min_valid_err = valid_error;
            min_validtest_err = test_error;
            min_valid_k = K;
        } else if (valid_error == min_valid_err && test_error < min_validtest_err) {
            min_validtest_err = test_error;
            min_valid_k = K;
        }

        fprintf(fpredic, "%d,%f,%f,%f\n", K, train_error, valid_error, test_error);
        printf("*** Fin de entrenamiento con K = %d (min %d). Train = %f, Validation = %f, Test = %f\n", K, min_valid_k, train_error, valid_error, test_error);
        if (CONTROL)
            fflush(NULL);

        /* Shuffle the access vector? */
        // shuffle(PTOT);
    }

    fprintf(fpredic, "Minimo error en validacion con K = %d, %f\n", min_valid_k, min_valid_err);

    fclose(fpredic);
    
    K = min_valid_k;

    /* Volvemos a entrenar el conjunto de test para el de menor validacion because why TF not */
    propagar(test, 0, PTEST, 0, 0);

    /* archivo de predicciones */
    sprintf(filepat, "%s.predic", filename);
    fpredic = fopen(filepat, "w");
    error = (fpredic == NULL);
    if (error) {
        printf("Error al abrir archivo para guardar predicciones\n");
        return 1;
    }
    for (k = 0; k < PTEST; k++) {
        for (i = 0; i < N_IN; i++)
            fprintf(fpredic, "%f\t", test[k][i]);
        fprintf(fpredic, "%d\n", pred[k]);
    }
    fclose(fpredic);

    return 0;
}

/* ----------------------------------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------------------------------- */
int main(int argc, char **argv)
{

    if (argc != 2) {
        printf
            ("Modo de uso: nb <filename>\ndonde filename es el nombre del archivo (sin extension)\n");
        return 0;
    }

    /* defino la estructura */
    error = arquitec(argv[1]);
    if (error) {
        printf("Error en la definicion de parametros\n");
        return 1;
    }

    /* leo los datos */
    error = read_data(argv[1]);
    if (error) {
        printf("Error en la lectura de datos\n");
        return 1;
    }

    /* ajusto los parametros y calcula errores en ajuste y test */
    error = train(argv[1]);
    if (error) {
        printf("Error en el ajuste\n");
        return 1;
    }

    return 0;

}

/* ----------------------------------------------------------------------------------------------------- */
