###################
### Run locally ###
###################

#Set working directory
  setwd("C:/Users/sabri/OneDrive/Desktop/HS23/Genome and Transcriptome Assembly_Organization and annotation of Eukaryote genomes/Exercises")
  #Install packages, only run when the packages are not installed yet
    #if (!require("BiocManager", quietly = TRUE)){
    #  install.packages("BiocManager")
    #}
      #BiocManager::install("rtracklayer")
    
    #if (!require("RColorBrewer", quietly = TRUE)){
    #  install.packages("RColorBrewer")
    #}

#Load the packages
  library(rtracklayer)
  library(RColorBrewer)

#Create funciton to round milions
  round_millions <- function(num){
    return(ceiling(num/1e+06)*1e+06)}

#Define path to merged assembly GFF3
  gff_path <- '05_TE_annotation/polished.fasta.mod.EDTA.TEanno.gff3'
  #Load GFF and convert it to a data frame
    gff <- rtracklayer::import(gff_path)
    gff_df <- as.data.frame(gff)

#Count the number of entries (features) for each scaffold
  scaffold_counts <- table(gff_df$seqnames)

#Find the scaffold with the most entries
  largest_scaff <- names(which.max(scaffold_counts))
  #Print the result
    print(paste("The scaffold with the most entries is:", largest_scaff, "with", scaffold_counts[largest_scaff], "entries."))

#Filter gff_df for the largest scaffold
  largest_scaff_gff <- subset(gff_df, gff_df$seqnames == largest_scaff)

#Get bins
  max_bp <- max(largest_scaff_gff$start)
  max_bp_round <- round_millions(max_bp)
  max_bin <- max_bp_round/1e+06
  bin_ends <- seq(1, max_bin)
  bin_strings <- string_sequence <- paste0(bin_ends - 1, "-", bin_ends, "Mbp")

#Get different clades (superfamilies etc.)
  clades <- unique(largest_scaff_gff$Classification)
  num_clades <- length(clades)
  clades_bins <- matrix(data = NA, nrow = num_clades, ncol = max_bin, dimnames = list('clades'= clades, 'bins' = bin_strings))

#Fill in bins
  for(clade in clades){
    for(bin_num in 1:max_bin){
      bin_start <- (bin_num-1) * 1e+06
      bin_end <- (bin_num) * 1e+06
      clades_bins[clade, bin_num] <- sum(largest_scaff_gff$Classification == clade & largest_scaff_gff$start >= bin_start & largest_scaff_gff$start < bin_end)
    }
  }

#Initialise pdf for the plots
  pdf(paste0('05_TE_annotation/TEs_by_Clades_and_Range_', largest_scaff, '.pdf'), width = max_bin + 2, height = 6)
  par(mar = c(7, 4.5, 5, 2.5))

#Create color palate. If there are more clades than colors in the palette, the palette colors will be repeated.
  colors_clades <- brewer.pal(min(8, num_clades), "Set3")
    if(num_clades > 8) {
      colors_clades <- colorRampPalette(colors_clades)(num_clades)
    }

#Plot
  barplot(clades_bins,
          beside = F, col = colors_clades, border = "white",
          xlab = "Range (start position)",
          ylab = "Frequency",
          main = paste0("TEs by Clades and Range for ", largest_scaff),
          cex.names = 0.8, las = 1)
  legend('topright', legend = clades, fill = colors_clades,
         cex = 0.8, bty = "n", inset = c(0.1, 0.05))

#Create color palate. If there are more clades than colors in the palette, the palette colors will be repeated.
  colors_bins <- brewer.pal(min(8, max_bin), "Paired")
    if(max_bin > 8) {
      colors_bins <- colorRampPalette(colors_bins)(max_bin)
    }

#Plot
  barplot(t(clades_bins),
          beside = T, col = colors_bins, border = "white",
          ylab = "Frequency",
          main = paste0("TEs by Clades and Range for ", largest_scaff),
          cex.names = 0.8, las = 2)
  mtext("Clade", side = 1, line = 5)
  legend('topright', legend = bin_strings, fill = colors_bins,
         cex = 0.8, bty = "n", inset = c(0.1, 0.05))

dev.off()
