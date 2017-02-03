names(melted_df) <- c("TAXA", "PROJECT", "ABUNDANCE")
library(jsonlite)
fileConn <- file("/Users/psenin/GitHub/heatmap/html/merged.json")
writeLines(prettify(minify(jsonlite::toJSON(melted_df))), fileConn)
close(fileConn)
#
write.table(melted_df, "/Users/psenin/GitHub/heatmap/html/merged.tsv", sep = "\t", col.names = T, row.names = F)