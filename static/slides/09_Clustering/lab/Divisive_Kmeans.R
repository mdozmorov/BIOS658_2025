### -----------------------------------------
### Familiar data
### -----------------------------------------
weight.kg <- c(15, 49, 13, 45, 85, 66, 12, 10)
height.cm <- c(95, 156, 95, 160, 178, 176, 90, 78)

data <- cbind(weight.kg, height.cm)
rownames(data) <- paste0("ID", 1:8)   # add labels
plot(data, pch = 19, col = "steelblue",
     main = "Scatter plot of samples",
     xlab = "Weight (kg)", ylab = "Height (cm)")
text(data, labels = rownames(data), pos = 4)

### -----------------------------------------
### Packages
### -----------------------------------------
library(cluster)

### -----------------------------------------
### Divisive hierarchical clustering (DIANA)
### -----------------------------------------
dist.daisy <- daisy(data)
diana.res  <- diana(dist.daisy)

### -----------------------------------------
### Agglomerative hierarchical clustering (hclust)
### -----------------------------------------
dist.hclust <- dist(data)  # Euclidean distance
hclust.res  <- hclust(dist.hclust, method = "complete")

### -----------------------------------------
### Compare dendrograms side by side
### -----------------------------------------
par(mfrow = c(1, 2))

plot(diana.res, main = "Divisive clustering (DIANA)",
     sub = "Top-down splitting", col = "firebrick")

plot(hclust.res, main = "Agglomerative clustering (hclust)",
     sub = "Bottom-up merging", col = "navy")

par(mfrow = c(1, 1))

### -----------------------------------------
### Optional: compare cluster memberships
### -----------------------------------------
# Cut trees into 2 clusters (just as an example)
cut_diana <- cutree(as.hclust(diana.res), k = 2)
cut_hclust <- cutree(hclust.res, k = 2)

cat("\nCluster memberships:\n")
data.frame(
  ID = rownames(data),
  DIANA = cut_diana,
  Agglomerative = cut_hclust
)

### -----------------------------------------
### Visual comparison on scatterplot
### -----------------------------------------
plot(data, pch = 19, col = cut_diana,
     main = "DIANA clusters (k=2)")
text(data, labels = rownames(data), pos = 4)

plot(data, pch = 19, col = cut_hclust,
     main = "Agglomerative clusters (k=2)")
text(data, labels = rownames(data), pos = 4)


### Partitioning methods

### K-means clustering
set.seed(23)
# Suppose K=2, randomly assign half obs to group 1 the rest to group 2
group <- sample(1:8, 4)  # Random indexes of samples in one group.
group
initial <- rep(2, 8)
initial
initial[group] <- 1
initial  # Initial (random) cluster assignment

# Calculate centers for each cluster
center.1 <- c(mean(weight.kg[initial == 1]), mean(height.cm[initial == 1]))
center.1
center.2 <- c(mean(weight.kg[initial == 2]), mean(height.cm[initial == 2]))
center.2

par(mfrow = c(1, 1))
plot(weight.kg, height.cm, type = "n")
points(center.1, pch = 24)
points(center.2, pch = 19)
points(47.75, 146, pch = 24)
points(26, 111, pch = 19)
text(weight.kg, height.cm, labels = initial) # First set of centroids

# Need to recalculate distance from all members to the centers
dist.1 <- matrix(rbind(cbind(weight.kg, height.cm), center.1), nrow = 9)  # row-Append centers to the original matrix
dist.1
round(dist(dist.1), 3) 
dist.2 <- matrix(rbind(cbind(weight.kg, height.cm), center.2), nrow = 9)
dist.2
round(dist(dist.2), 3)
# Define cluster assignment from comparing dist(dist1) and dist(dist2)
# Compare last lines - which numbers are smaller? Meaning, which centroid a given element is closest to
second <- c(2, 1, 2, 1, 1, 1, 2, 2)  
# Recalculate centroids
center.1 <- c(mean(weight.kg[second == 1]), mean(height.cm[second == 1]))
center.1
center.2 <- c(mean(weight.kg[second == 2]), mean(height.cm[second == 2]))
center.2
# Visualize them
plot(weight.kg, height.cm, type = "n")
points(t(center.1), pch = 24)
points(t(center.2), pch = 19)
text(weight.kg, height.cm, labels = second)

# Do the second round yourself
dist.1 <- matrix(rbind(cbind(weight.kg, height.cm), center.1), nrow = 9)
dist.2 <- matrix(rbind(cbind(weight.kg, height.cm), center.2), nrow = 9)
round(dist(dist.1), 3)
round(dist(dist.2), 3)
second <- c(2, 1, 2, 1 , 1, 1, 2, 2) # Fill in the new cluster assignment
