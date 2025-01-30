#Author: Nabin Pradhan
#Date: 23-Nov-2023
#Project: Inequality
###############################

# Load required package
library(readstata13)

# Input dataset
data_dhs_15 <- read.dta13(".dta")

# Check data structure
str(data_dhs_15)
# Convert selected variables to factors using lapply
factor_vars <- c("electric", "cook_clean", "toilet_facility", "radio", "tv", "mobile", 
                 "comp", "frig", "bike", "moto", "agriland", "animals", "watersource", 
                 "hh_edu", "hh_sex", "hh_structure", "hfloor", "hroof", "hwall", 
                 "bank", "bpl_card")

data_dhs_15[factor_vars] <- lapply(data_dhs_15[factor_vars], as.factor)

# Construct design matrix for PCA (excluding intercept)
matrix_pca_15 <- model.matrix( 
  ~ hfloor + hroof + hwall + watersource + cook_clean + toilet_facility +
    tv + mobile + frig + bike + moto +
    agriland + animals + hh_edu + hh_structure +
    bpl_card + bank - 1,  # Exclude intercept
  data = data_dhs_15)

# Execute PCA using prcomp (more numerically stable)
pca_asset_dhs15 <- prcomp(matrix_pca_15, center = TRUE, scale. = TRUE)

# Select the first principal component
data_dhs_15$pca1 <- pca_asset_dhs15$x[, 1]

## End
