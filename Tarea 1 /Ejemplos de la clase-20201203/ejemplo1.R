library(magrittr)


# Asignar una funcion -----------------------------------------------------

suma <- function(x, y) x + y
resta <- function(x, y) x - y
multiplicacion <- function(x, y) x * y


# Almacenar funciones en una lista ----------------------------------------

funciones[[1]](3) # equivalente a suma(3)
funciones[[2]](5) # equivalente a resta(5)
funciones[[3]](2) # equivalente a multiplicacion(2)



# Pasar funciones como paramentro a otra funcion ---------------------------

operacion <- function(operador) {
  function(x,y) operador(x,y)
}

suma <- operacion(`+`)
resta <- operacion(`-`)
potencia <- operacion(`^`)

suma(3,3)
resta(3,1)
potencia(3,2)
