require(dplyr)
require(ggplot2)
require(tibble)
require(readr)
require(tidyr)

# Create some data
A <- rnorm(1000)
B <- rnorm(1000, 2)
C <- rlnorm(1000)

# Add into data frame
df <- tibble(A, B, C) %>% 
  mutate(D = log(C))

# Write data to file
if(!dir.exists("data"))
{
  dir.create("data")
}
write_csv(df, "data/raw_data.csv")

# Transform
df %>% 
  pivot_longer(1:4) %>% 
  # Plot
  ggplot(aes(x = value))+
  geom_density(aes(fill = name),
               alpha = 0.8)+
  theme_classic(20)+
  scale_fill_brewer(palette = "Set1")

# Write plot
if(!dir.exists("figures"))
{
  dir.create("figures")
}
ggsave("figures/plot.png",
       height = 6, width = 6)
