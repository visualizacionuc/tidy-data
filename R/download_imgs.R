library(tidyverse)
library(rvest)

url <- "http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html"

html <- read_html(url) 


html %>% 
  html_nodes("img") %>% 
  html_attr("src") %>% 
  file.path(dirname(url), .) %>% 
  map(function(x){
    
    download.file(x, file.path("img/charts", basename(x)), mode = 'wb')
    
  })
