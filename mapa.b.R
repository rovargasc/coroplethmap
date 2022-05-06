
# This file is a generated template, your changes will not be overwritten

mapaClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "mapaClass",
    inherit = mapaBase,
    private = list(
        .run = function() {
          # Defino las variables a usar normalito...
          long <- self$options$long 
          lat <- self$options$lat
          group <- self$options$group
          medida <- self$options$medida
          
          # Voy a crear los nombres de las variables 
          varNames <- c(long, lat, group, medida)
          # Jugada maestra para que no salgan errores. Dice lo siguiente:
          # Si alguno de esos es nulo, retorne "nada". Para que no salgan mensajes raros...
          if (is.null(long) || is.null(lat) || is.null(group) || is.null(medida))
            return()
          
          Dataset <- jmvcore::select(self$data, varNames) # Selecciono las variables de los datos (jugada? names)
          
          image <- self$results$plot  # Esto toca así sí o sí
          image$setState(Dataset)  # también Sí o sí
          
        },
        .plot=function(image, ...){  # Esto también es estándar
          
          Dataset <- image$state    # Ok...
          
          PlotData <- Dataset[,c(1:4)] 
          #colnames(PlotData) <- c("long", 'lat', 'group', 'medida')
          
          p <- ggplot2::ggplot() +  # primera capa
            ggplot2::geom_polygon(data=PlotData,  # segunda capa
                                  aes(x=self$options$long,
                                      y=self$options$lat,
                                      group=self$options$group,
                                      fill=jmvcore::toNumeric(self$options$medida)),
                                  color='black') +
            ggplot2::coord_map('polyconic') +  ggplot2::scale_fill_viridis_c() +
            ggplot2::scale_fill_gradient2(low="#559999",
                                          mid="grey90",
                                          high="#BB650B")
           
          
          print(p)
          TRUE
          
        }
    )
)
