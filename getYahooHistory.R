#.rs.restartR()
rm(list = ls())

library(tictoc)
library(doSNOW)
library(foreach)
library(doParallel)
library(data.table)

source("C:\\Users\\kim_t\\Desktop\\algo\\header\\headerYahooHistory.R")

yr1 <- 5
yr2 <- 1

getSPY()
getWTI()

################################################################################
### --- Internet Archive --- ###################################################
################################################################################
###
### https://stackoverflow.com/questions/56317496/generating-an-index-of-values-to-compound-but-ignoring-initial-value-in-a-scala
### https://stackoverflow.com/questions/5423760/how-do-you-create-a-progress-bar-when-using-the-foreach-function-in-r
### https://stackoverflow.com/questions/40684721/how-to-show-the-progress-of-code-in-parallel-computation-in-r
### https://stackoverflow.com/questions/45764796/cpu-usage-when-using-foreach-in-r
###
################################################################################

# marketcap<- read.csv("C:\\Users\\kim_t\\Desktop\\algo\\fundamentals_2022-03-14.csv") %>%
#             rename(ticker = names(.)[1]) %>% select(ticker, marketCap)
# options  <- as.vector(unlist(read.csv("C:\\Users\\kim_t\\Desktop\\data\\options\\ListedOptions_2022-02-09.csv") %>%
#             select(x)))
# file_    <- left_join(marketcap, exchanges, by = "ticker") %>% filter(!(ticker %in% options))
#             
# tickers  <- as.vector(unlist(file_ %>% select(ticker)))

exchange <- read.csv("C:\\Users\\kim_t\\Desktop\\algo\\yahooTickers_2022-03-21.csv") 
tickers1 <- as.vector(unlist(exchange %>% select(ticker))) 
tickers1 <- tickers1[!(tickers1 %in% "PRN")]
tickers2 <- list()

for (i in 1:ceiling(length(tickers1)/1000)) {
  
  if (i < 18) {
    
    tickers2[[i]] <- tickers1[((i-1)*1000+1):(i*1000)]
  }
  else {
    
    tickers2[[i]] <- tickers1[((i-1)*1000+1):length(tickers1)]
  }
}

for (j in 1:length(tickers2)) {
  
  cl       <- makeCluster(detectCores(logical = TRUE)); registerDoSNOW(cl)
  pb       <- txtProgressBar(max = length(tickers2[[j]]), style = 3)
  progress <- function(n) setTxtProgressBar(pb, n)
  opts     <- list(progress = progress)
  
  tic();
  df_ <- foreach(i     = 1:length(tickers2[[j]]), 
         .combine      = rbind, 
         .packages     = c("quantmod", "tidyverse"),
         .options.snow = opts) %dopar% {
    
    getData(tickers2[[j]][i])
    
  }; 
  close(pb); stopCluster(cl); toc();

  tic(); fwrite(df_, paste0("C:\\Users\\kim_t\\Desktop\\data\\history\\", "history_universe_", gsub(" ", "_", gsub(":", "", as.character(Sys.Date()))), "_part_", j, ".csv")); toc()
  
  rm(df_)
}
