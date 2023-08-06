install.packages("here")

library("here")

install.packages("skimr")

library("skimr")

install.packages("janitor")

library("janitor") 

install.packages("dplyr")

library("dplyr")



install.packages("palmerpenguins")

library("palmerpenguins")



skim_without_charts(penguins)

glimpse(penguins)

head(penguins)

clean_names(penguins)


install.packages("tidyverse")

library("tidyverse")

penguins %>% arrange(bill_length_mm)

penguins <- penguins %>% arrange(bill_length_mm)

penguins %>% group_by(island) %>% drop_na() %>% summarize(mean_bill_length_mm = mean(bill_length_mm))

penguins %>% group_by(island) %>% drop_na() %>% summarize(max_bill_length_mm = max(bill_length_mm))

penguins %>% group_by(species, island) %>% drop_na() %>% summarize(max_bl = max(bill_length_mm), mean_bl = mean(bill_length_mm))



install.packages("ggplot2")

library("ggplot2")

ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(aes(color=species))

ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(aes(color=species))+
  facet_wrap(~species)

ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(aes(color=species))+
  facet_wrap(~species)+
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length")

ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(aes(color=species))+
  facet_wrap(~species)+
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length",subtitle="Sample of Three Penguin Species")

ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(aes(color=species))+
  facet_wrap(~species)+
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length",subtitle="Sample of Three Penguin Species",caption="Data collected by Dr. Kristen Gorman")

ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(aes(color=species))+
  facet_wrap(~species)+
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length",subtitle="Sample of Three Penguin Species",caption="Data collected by Dr. Kristen Gorman")

