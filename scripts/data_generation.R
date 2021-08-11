require(dplyr)
require(ggplot2)
require(tibble)
require(readr)
require(tidyr)
require(janitor)
require(beepr)

# Create some data
A <- rnorm(1000)
B <- rep(c("Class 1", "Class 2"), 500)
C <- rlnorm(1000)

# Add into data frame
df <- tibble(A, B, C) %>% 
  mutate(D = log(C))

# Tables of summary statistics
tabyl(df, B)
df %>% 
  group_by(B) %>% 
  summarise(meanA = mean(A),
            meanC = mean(C),
            meanD = mean(D))

# Write data to file
if(!dir.exists("data"))
{
  dir.create("data")
}
write_csv(df, "data/raw_data.csv")

# Transform
df %>% 
  pivot_longer(c(1,3,4)) %>% 
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
       height = 6, width = 9)
beep()
