

#------------ "k-means" Clustering ------------#


library(tidyverse) # The 'tidyverse' is a set of packages that work in harmony because they share common data representations
library(magrittr) # %>%

library(cluster) # Methods for Cluster analysis.
library(cluster.datasets) # Library's datasets
library(dendextend) # Set of functions for extending dendrogram objects in R, letting you visualize and compare trees of hierarchical clusterings
library(factoextra) # Easy-to-use functions to extract and visualize the output of multivariate data analyses
library(FactoMineR) # Exploratory data analysis methods to summarize, visualize and describe datasets

library(cowplot)# The cowplot package is a simple add-on to ggplot2. It is meant to provide a publication-ready theme for ggplot2
library(ggfortify) # ggfortify extends ggplot2 for plotting some popular R packages using a standardized approachz
library(corrplot) # Graphical display of matrix correlation
library(GGally) # 'GGally' extends 'ggplot2' by adding several functions to reduce the complexity of combining geometric objects 
library(ggiraphExtra) # Collection of functions to enhance 'ggplot2' and 'ggiraph'
library(clustree) # Plotting clustering trees
library(NbClust) # Provides 30 indices to help the user choose the optimal amount of clusters
library(clValid) # Statistical and biological validation of clustering results.

library(knitr) # Dynamic report generator
library(kableExtra) # Table generator

# Importing the data from "cluster.datasets"
data("all.mammals.milk.1956")
raw_mammals <- all.mammals.milk.1956
head(raw_mammals)

# Subsetting dataset
mammals <- raw_mammals %>% select(-name) # setting rownames
mammals <- as_tibble(mammals)

glimpse(mammals) # simillar to head - like, sort of...
head(mammals)
summary(mammals) %>% kable() %>% kable_styling() # Visualize summary in the "Viewer" --->



#------------ Exploratory Data Analysis ------------#


# Historgram for each attribute
mammals %>% 
        gather(Attributes, value, 1:5) %>% 
        ggplot(aes(x=value)) +
        geom_histogram(fill = "lightblue2", color = "black") + 
        facet_wrap(~Attributes, scales = "free_x") +
        labs(x = "Value", y = "Frequency")

# Correlation matrix - viz
corrplot(cor(mammals), type = "upper", method = "circle", tl.cex = 0.9)

# Scaling the data - helps when variables are in different measures
mammals_scaled <- scale(mammals)
rownames(mammals_scaled) <- raw_mammals$name # Setting row-names again :)

# Dimensionality reduction can help with visualization

res.pca <- PCA(mammals_scaled,  graph = FALSE)

# Visualize eigenvalues/variances
fviz_screeplot(res.pca, addlabels = TRUE, ylim = c(0, 80)) 
# ^^^ These are the 5 PCs that capture 80% of the variance. The scree plot shows that PC1 captured ~ 76.2 of the variance.


