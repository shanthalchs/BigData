library(tidyverse)

datos <- iris[,-5]
k <- 2:10

calcular_grupos <- function(datos, k) {
  kmeans(x = datos, centers = k, iter.max = 200, nstart = 100)
}

modelo <- map(.x = 2:10, .f = calcular_grupos, datos = datos)
inercia <- map_dbl(modelo, "tot.withinss")

resultados <- tibble(k = k, modelo, inercia)
resultados

ggplot(data = resultados,
       mapping = aes(x = k, y = inercia)) +
  geom_line()+
  geom_point() +
  theme_minimal() +
  scale_x_continuous(breaks = 2:10)
