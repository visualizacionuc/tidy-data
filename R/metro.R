library(tidyverse)
library(lubridate)

# url <- "https://github.com/jbkunst/r-material/blob/gh-pages/201710-Visualizacion-en-el-Analisis/data/2015.04_Subidas_paradero_mediahora_web/2015.04_Subidas_paradero_mediahora_web.csv"


# lo fome -----------------------------------------------------------------
url <- "https://tinyurl.com/data-metro-scl"
path <- "data/2015.04_Subidas_paradero_mediahora_web.csv"

data <- read_delim(path, delim = ";")
data

data <- data %>% 
  filter(!str_detect(paraderosubida, "[0-9]+-[0-9]"))

data <- data %>% 
  filter(paraderosubida != "-")

data <- data %>% 
  filter(hour(mediahora) > 0)


# interesante -------------------------------------------------------------
ggplot(data) +
  geom_point(aes(subidas_laboral_promedio, mediahora))

ggplot(data) +
  geom_point(aes(x = mediahora, y = subidas_laboral_promedio))

ggplot(data) +
  geom_point(aes(x = mediahora, y = subidas_laboral_promedio), alpha = 0.02, size = 2) +
  geom_smooth(aes(x = mediahora, y = subidas_laboral_promedio))

ggplot(data) +
  geom_point(aes(x = mediahora, y = subidas_laboral_promedio, color = paraderosubida),
             alpha = 1, size = 2) +
  geom_smooth(aes(x = mediahora, y = subidas_laboral_promedio)) +
  theme(legend.position = "none")


# datita ------------------------------------------------------------------
datita <- data %>% 
  filter(paraderosubida == "ALCANTARA")

ggplot(datita) +
  geom_point(aes(x = mediahora, y = subidas_laboral_promedio),
             alpha = 1, size = 2) 

ggplot(datita) +
  geom_line(aes(x = mediahora, y = subidas_laboral_promedio)) 

datita <- data %>% 
  filter(paraderosubida == "UNIVERSIDAD DE CHILE")

ggplot(datita) +
  geom_line(aes(x = mediahora, y = subidas_laboral_promedio)) 



# Comparacion -------------------------------------------------------------
est <- c("ALCANTARA", "UNIVERSIDAD DE CHILE", "PAJARITOS", "PLAZA MAIPU",
         "LA CISTERNA L2", "BELLAS ARTES", "EL GOLF", "ESCUELA MILITAR", "NUBLE", 
         "PLAZA DE PUENTE ALTO")

datota <- data %>% 
  filter(paraderosubida %in% est)

datota %>% count(paraderosubida)

library(viridis)
ggplot(datota) +
  geom_line(aes(x = mediahora, y = subidas_laboral_promedio, color = paraderosubida),
            size = 3) +
  scale_color_viridis(discrete = TRUE, option = "B") +
  facet_wrap( ~ paraderosubida, scales = "free")



  


