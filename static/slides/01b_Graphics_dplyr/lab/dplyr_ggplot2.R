# dplyr and ggplot2 tutorial
# Amanda Gentry and Mikhail Dozmorov, Ph.D.
# http://www.sharpsightlabs.com/dplyr-intro-data-manipulation-with-r/

library(dplyr)
library(ggplot2)

# The pipe %>% operator
# Remember that the %>% operator says "take ____ and then do ___ and then do ___ etc."
head(diamonds) 
diamonds %>% head

# See that the "." works as a sort of placeholder
summary(diamonds$price)
diamonds$price %>% summary(object = .)

# dplyr::filter()
diamonds %>% head

df.diamonds_ideal <- filter(diamonds, cut == "Ideal")
df.diamonds_ideal <- diamonds %>% filter(cut == "Ideal")

# dplyr::select()
df.diamonds_ideal %>% head

select(df.diamonds_ideal, carat, cut, color, price, clarity)
df.diamonds_ideal <- df.diamonds_ideal %>% select(., carat, cut, color, price, clarity)

# dplyr::mutate()
df.diamonds_ideal %>% head

mutate(df.diamonds_ideal, price_per_carat = price/carat)
df.diamonds_ideal <- df.diamonds_ideal %>% mutate(price_per_carat = price/carat)

# dplyr::arrange()
df.diamonds_ideal %>% head

arrange(df.diamonds_ideal, price)
df.diamonds_ideal %>% arrange(price, price_per_carat)

# dplyr::summarise()
summarize(df.diamonds_ideal, length = n(), avg_price = mean(price))
df.diamonds_ideal %>% summarize(length = n(), avg_price = mean(price))

# dplyr::group_by()
group_by(diamonds, cut) %>% summarize(mean(price))
group_by(diamonds, cut, color) %>% summarize(mean(price))

# The power of pipe %>%
# See that the same task may be accomplished in multiple ways
# Combining the functions of dplyr and the pipe, your code can
# be made easier to read and understand
# -------------------------------------#
# Understand this
arrange(mutate(arrange(filter(tbl_df(diamonds), cut == "Ideal"), price), price_per_carat = price/carat), price_per_carat)

# Compare with this
arrange(
  mutate(
    arrange(
      filter(tbl_df(diamonds), cut == "Ideal"), 
    price), 
  price_per_carat = price/carat), 
price_per_carat)

# Enjoy the logic of this
diamonds %>% filter(cut == "Ideal") %>% arrange(price) %>% mutate(price_per_carat = price/carat) %>% arrange(price_per_carat)

# The %>% operator can feed directly into a plot statement
# ggplot2
diamonds %>% filter(cut == "Good", color == "E") %>% 
  ggplot(aes(x = price, y = carat)) +
  geom_point()  # aes(size = price)
# Try other geoms, instead of geom_point()
  geom_smooth() # method = lm
  geom_line()
  geom_boxplot()
  geom_bar(stat="identity")
  geom_histogram()

# Put it all together
diamonds %>%                  # Start with the 'diamonds' dataset
  filter(cut == "Ideal") %>%  # Then, filter down to rows where cut == Ideal
  ggplot(aes(price)) +        # Then, plot using ggplot
  geom_histogram(bins = 20) + # and plot histograms
  facet_wrap(~ color) +       # in a 'small multiple' plot, broken out by 'color' 
  ggtitle("Diamond price distribution per color") +
  labs(x="Price", y="Count") +
  theme(panel.background = element_rect(fill="lightgreen")) +
  theme(plot.title = element_text(family="Trebuchet MS", size=28, face="bold", hjust=0, color="#777777")) +
  theme(axis.title.y = element_text(angle=0)) +
  theme(panel.grid.minor = element_blank())


