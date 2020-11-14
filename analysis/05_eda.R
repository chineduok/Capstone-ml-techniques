#Exploratory Data Analysis

ggplot(per_yr_sales15, aes(Dry_Grocery)) +
  geom_density(fill = 'blue',color = 'black')+ 
  facet_grid(.~Cluster) + theme_bw()

ggplot(per_yr_sales, aes(Dairy)) +
  geom_density(fill = 'lightyellow2',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()


ggplot(per_yr_sales, aes(Frozen_Food)) +
  geom_density(fill = 'lightgoldenrod4',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()


ggplot(per_yr_sales, aes(Meat)) +
  geom_density(fill = 'firebrick',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()

ggplot(per_yr_sales, aes(Produce)) +
  geom_density(fill = 'lightyellow2',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()

ggplot(per_yr_sales, aes(Floral)) +
  geom_density(fill = 'mediumaquamarine',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()


ggplot(per_yr_sales, aes(Deli)) +
  geom_density(fill = 'indianred1',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()

ggplot(per_yr_sales, aes(Bakery)) +
  geom_density(fill = 'navajowhite2',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()

ggplot(per_yr_sales, aes(General_Merchandise)) +
  geom_density(fill = 'magenta3',color = 'black')+ 
  facet_grid(.~Year) + theme_gray()


ggplot(per_yr_sales, aes(Dry_Grocery, Dairy))+
  geom_point()