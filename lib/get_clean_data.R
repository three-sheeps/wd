get_clean_data <- function() {
  
  # read in mammal metabolism data
  mammal_met <- read.table("data/data.txt", sep = "\t",
                           header = TRUE, na.strings = -9999)
  names(mammal_met) <- c("Subclass", "Order", "Species",
                         "BMR", "Mass.BMR", "Reference.BMR", "FMR",
                         "Mass.FMR", "Reference.FMR")
  
  # cleaning species names to "Genus species"
  mammal_met$Species <- gsub("([A-Z][a-z]+\\s[a-z]+).*",
                             "\\1",
                             mammal_met$Species)
  
  # read in mammal diet data
  mammal_diet <- read.table("data/MammalDIET_v1.0.txt", sep = "\t",
                            header = TRUE)
  
  # cleaning Species to "Genus species", deleting Genus field
  mammal_diet$Species <- paste(mammal_diet$Genus, mammal_diet$Species)
  mammal_diet$Genus <- NULL
  
  # wordcase Order to match Order in metabolism data, same with Family
  mammal_diet$Order <- paste0(
    substr(mammal_diet$Order, 1, 1),
    tolower(substr(mammal_diet$Order, 2, 1000L))
  )
  
  mammal_diet$Family <- paste0(
    substr(mammal_diet$Family, 1, 1),
    tolower(substr(mammal_diet$Family, 2, 1000L))
  )
  
  # merge data based on unique species
  mammal <- merge(mammal_diet, mammal_met, by = c("Species", "Order"))
  
  # return mammal
  mammal
}
