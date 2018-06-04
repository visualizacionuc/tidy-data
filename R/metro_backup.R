#' ---
#' output: word_document
#' ---
#' 
#' Cargamos librerias
library(tidyverse)

# url <- "https://github.com/jbkunst/r-material/blob/gh-pages/201710-Visualizacion-en-el-Analisis/data/2015.04_Subidas_paradero_mediahora_web/2015.04_Subidas_paradero_mediahora_web.csv"

url <- "https://tinyurl.com/data-metro-scl"

data <- read_delim(url, delim = ";")
head(data)



# Clasifiquemos -----------------------------------------------------------
data_resumen1 <- data %>% 
  group_by(paraderosubida) %>% 
  summarise(subidas_total = sum(subidas_laboral_promedio)) %>% 
  mutate(tipo_1 = ifelse(subidas_total > mean(subidas_total), "congestion", "piola"))

data_resumen2 <- data %>% 
  mutate(horario = ifelse(hour(mediahora) <= 12, "am", "pm")) %>% 
  group_by(paraderosubida, horario) %>% 
  summarise(subidas_horario = sum(subidas_laboral_promedio)) %>% 
  # como las tablas dinamias
  spread(horario, subidas_horario) %>% 
  mutate(tipo_2 = ifelse(am >= pm, "dormitorio", "laboral")) 


data_resumen <- inner_join(data_resumen1, data_resumen2)
data_resumen <- data_resumen %>% select(paraderosubida, tipo_1, tipo_2)
data_resumen

data_resumen %>% 
  filter(tipo_1 == "congestion", tipo_2 == "dormitorio")

data_resumen %>% 
  arrange(tipo_1, tipo_2) %>% 
  View()

data <- left_join(data, data_resumen)

ggplot(data) +
  geom_line(aes(x = mediahora, y = subidas_laboral_promedio, group = paraderosubida),
            alpha = 0.1, size = 1) +
  geom_smooth(aes(x = mediahora, y = subidas_laboral_promedio)) + 
  facet_wrap(tipo_2 ~ tipo_1) 


