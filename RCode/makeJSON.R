#
# Produces the merged.tsv and merged.json datasets from the raw assignment data
#
# Pavel Senin, June, 21, 2017
#
#
require(MetaComp)

#
#
list_dirs <- function(path = ".", pattern = NULL, all.dirs = FALSE,
                      full.names = FALSE, ignore.case = FALSE) {
  # use full.names=TRUE to pass to file.info
  all <-  list.files(path, pattern, all.dirs, full.names = TRUE, recursive = FALSE, ignore.case)
  dirs <- all[file.info(all)$isdir]
  if (isTRUE(full.names))
    return(dirs)
  else
    return(basename(dirs))
}

# projects
#
projects <- data.frame(folder = file.path("../data",
                                 list_dirs("../data")), stringsAsFactors = F)
projects <- data.frame(folder = projects[grep(".*SRR*", projects$folder), ], stringsAsFactors = F)
#
name_pattern <- paste(".*", .Platform$file.sep, "(.*)", sep = "")
projects$accession <- paste("Project_", stringr::str_match(projects$folder,
                                                           name_pattern)[, 2], sep = "")

# taxonomic assignments
#
find_file <-  function(path = ".", filename = "", recursive = TRUE) {
  all <- list.files(path, filename, full.names = TRUE, recursive = recursive, ignore.case = TRUE)
  all <- all[!file.info(all)$isdir]
  if (length(all) > 0) {
    return(all)
  }else {
    return(NA)
  }
}
#
projects$assignment <-
  plyr::daply(projects, plyr::.(accession), function(x) {
    find_file(paste(x$folder, .Platform$file.sep, sep = ""),
              "allReads.summary.tsv", recursive = T)
  })
projects <- dplyr::filter(projects, !(is.na(assignment)))

# make a list
#
input_assignments_list <- plyr::dlply(projects, plyr::.(accession), function(x){
  dat <- load_gottcha2_assignment(x$assignment)
  dat
})
names(input_assignments_list) <- projects$accession

# merge assignments
#
merged <- merge_gottcha_assignments(input_assignments_list)

# use only family
#
merged <- merged[merged$LEVEL == "family", ]
merged <- merged[, c(2:7)]

#
#
library(reshape2)
melted <- melt(merged, id.vars = c("TAXA"))
names(melted) <- c("TAXA", "PROJECT", "ABUNDANCE")
melted$PROJECT <- gsub("Project_", "", melted$PROJECT)
write.table(melted, "../data/merged.tsv", sep = '\t', quote = T, col.names = T, row.names = F)

# produce the merged data frame
#

library(jsonlite)
#
#
write(toJSON(melted), "../data/merged.json")

