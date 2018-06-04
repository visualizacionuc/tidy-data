#' ---
#' output: word_document
#' ---
#' Cargamos librerias
library(tidyverse)

# url <- "https://github.com/jbkunst/r-material/blob/gh-pages/201710-Visualizacion-en-el-Analisis/data/2015.04_Subidas_paradero_mediahora_web/2015.04_Subidas_paradero_mediahora_web.csv"

url <- "https://tinyurl.com/data-metro-scl"

data <- read_delim(url, delim = ";")
head(data)



