library(tidyverse)
library(randomForest)
library(rsample)


#crea una separación binaria de los datos entre trainingy testing
datos <- initial_split(data = iris, prop = 0.75, strata = "Species")

#analysis y assesment reciben objetos de tipo rsplit y retornan un data.frame
entrenamiento <- analysis(datos)
prueba <- assessment(datos)


#combinatoria de estos parametros para el árbol
parametros <- expand.grid(mtry = c(1,2,3), ntree = c(1,2,3))
#lo hace de tipo tibble (dataframe más detallado)
parametros <- as_tibble(parametros)
parametros

#map aplica a cada elemento de la lista la función
# Crear Modelos -----------------------------------------------------------
modelo <- map(transpose(parametros), function (x, datos){
  randomForest(Species~.,
               data = datos,
               mtry = x$mtry,
               ntree = x$ntree)
}, datos = entrenamiento)


# Calcular matrices de confusion ------------------------------------------

#variable a predecir Species
errores <- map(modelo, function (modelo, datos){
    prediccion <- predict(modelo, datos)
    mc <- table(datos$Species, prediccion)
    
    tibble(precision_global = sum(diag(mc))/sum(mc), error = 1-precision_global)
}, datos = prueba)


#toma los elementos de la lista y los hace un solo vector
errores <- reduce(errores, rbind)

#los une con los parámetos respectivos
resultado <- cbind(parametros, errores)
resultado
