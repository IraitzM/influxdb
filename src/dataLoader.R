# Auxiliary script to load data in case Santander's website malfunctions
library("lubridate")

load_data <- function(){
  out <- tryCatch(
    {
      # Get the information
      url <- "http://datos.santander.es/api/rest/datasets/mediciones.csv?items=482&rnd=863974585"
      data <- read.csv(url)
      return(data)
    },
    error=function(e) {
      # Choose a return value in case of error
      aux_df <- read.csv("../src/template.csv")
      aux_df['dc.modified'] <- format(now("UTC"), format = "%FT%R:00Z")
      return(aux_df)
    },
    warning=function(w) {
      # Choose a return value in case of error
      aux_df <- read.csv("../src/template.csv")
      aux_df['dc.modified'] <- format(now("UTC"), format = "%FT%R:00Z")
      return(aux_df)
    }
  )
  return(out)
}

data <- load_data()
