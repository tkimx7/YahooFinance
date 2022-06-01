#.rs.restartR()
#rm(list = ls())

library(quantmod)
library(tidyverse)

################################################################################
### --- getSPY --- #############################################################
################################################################################

getSPY <- function() {
  
  spy1 <-  getSymbols("SPY", from = from_, to = to_, auto.assign = FALSE)
  
  spy  <<- data.frame(spy1)                                                     %>%
           rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
                  close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
           mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
           fill  (close)                                                        %>%
           mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
           mutate(spy     = cumprod(c(100, ret[-1])))                           %>%
           mutate(ticker  = "SPY")                                              %>%
           mutate(date    = as.character(index(spy1)))                          %>%
           remove_rownames()
}

################################################################################
### --- getWTI --- #############################################################
################################################################################
###
### --- WTI Light Sweet Crude Oil Futures (CL) are standardized, exchange-traded 
### --- contracts which trade on the New York Mercantile Exchange (NYMEX). Each 
### --- contract of the CL represents 1,000 barrels of oil, or 42,000 gallons
### --- West Texas Intermediate (WTI) is a light, sweet crude oil that serves as 
### --- one of the main global oil benchmarks. It is sourced primarily from 
### --- inland Texas and is one of the highest quality oils in the world, which 
### --- is easy to refine. WTI is the underlying commodity for the NYMEX's oil 
### --- futures contract. WTI is often compared to Brent crude, which is an oil 
### --- benchmark for two-thirds of the world's oil contracts based on oil 
### --- extracted in the North Sea. West Texas Intermediate (WTI) crude oil is a 
### --- specific grade of crude oil and one of the main three benchmarks in oil 
### --- pricing, along with Brent and Dubai Crude. WTI is known as a light sweet 
### --- oil because it contains around 0.34% sulfur, making it "sweet," and has 
### --- a low density (specific gravity), making it "light."
################################################################################

getWTI <- function() {
  
  wti1 <-  getSymbols("CL=F", from = from_, to = to_, auto.assign = F)
  
  wti  <<- data.frame(wti1)                                                     %>%
           rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
                  close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
           mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
           fill  (close)                                                        %>%
           mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
           mutate(wti     = cumprod(c(100, ret[-1])))                           %>%
           mutate(ticker  = "WTI")                                              %>%
           mutate(date    = as.character(index(wti1)))                          %>%
           remove_rownames()
}

################################################################################
### --- getYield --- ###########################################################
################################################################################
###
### --- https://www.businessinsider.com/personal-finance/treasury-bonds
###
### --- Treasury bills mature within four, eight, 13, 26, or 52 weeks. They're 
### --- sold at a discount, which means you can buy one for a price below its 
### --- face value. But you receive the full face value (plus interest) at 
### --- maturity. These are notorious for having extremely low returns.
###
### --- Treasury notes mature within two to 10 years and pay interest every six 
### --- months. They're sold at a discount, coupon, or premium, which means the 
### --- price can be less than, equal to, or greater than the note's face value. 
### 
### --- Treasury bonds are also sold at discount, coupon, or premium and mature 
### --- in 20 years or 30 years. Bondholders receive interest every six months.
###
### --- Treasury Inflation-Protected Securities (TIPS) mature within five, 10, 
### --- or 30 years and pay interest every six months. TIPS can help protect 
### --- your investment against inflation because the principal increases with 
### --- inflation. (Though it also decreases with deflation.) At maturity, you 
### --- receive either the adjusted principal or original principal, whichever 
### --- is greater.

getYield <- function() {
  
  yld131 <- suppressWarnings(getSymbols("^IRX", from = from_, to = to_, auto.assign = F))
  yld051 <- suppressWarnings(getSymbols("^FVX", from = from_, to = to_, auto.assign = F))
  yld101 <- suppressWarnings(getSymbols("^TNX", from = from_, to = to_, auto.assign = F))
  yld301 <- suppressWarnings(getSymbols("^TYX", from = from_, to = to_, auto.assign = F))
  
  yld13  <<- data.frame(yld131)                                                   %>%
             rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
                    close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
             mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
             fill  (close)                                                        %>%
             mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
             mutate(yld13   = cumprod(c(100, ret[-1])))                           %>%
             mutate(ticker  = "yld13")                                            %>%
             mutate(date    = as.character(index(yld131)))                        %>%
             remove_rownames()
  
  yld05  <<- data.frame(yld051)                                                   %>%
             rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
                    close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
             mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
             fill  (close)                                                        %>%
             mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
             mutate(yld05   = cumprod(c(100, ret[-1])))                           %>%
             mutate(ticker  = "yld05")                                            %>%
             mutate(date    = as.character(index(yld051)))                        %>%
             remove_rownames()

  yld10  <<- data.frame(yld101)                                                   %>%
             rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
                    close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
             mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
             fill  (close)                                                        %>%
             mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
             mutate(yld10   = cumprod(c(100, ret[-1])))                           %>%
             mutate(ticker  = "yld10")                                            %>%
             mutate(date    = as.character(index(yld101)))                        %>%
             remove_rownames()

  yld30  <<- data.frame(yld301)                                                   %>%
             rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
                    close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
             mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
             fill  (close)                                                        %>%
             mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
             mutate(yld30   = cumprod(c(100, ret[-1])))                           %>%
             mutate(ticker  = "yld30")                                            %>%
             mutate(date    = as.character(index(yld301)))                        %>%
             remove_rownames()
}

################################################################################
### --- getData --- ############################################################
### 
### --- Splits are all reflected in close
### --- Reverse Split: E.g., NVAX announced 1-for-20 RS on 2019-05-08, 
### --- effective at 12:01am on 2019-05-10. Shows as 20 on 2019-05-10
### --- Split: E.g., TSLA announced 5-for-1 split on 2020-08-11, 
### --- effective at 12:01am on 2020-08-31. Shows as 0.2 on 2020-08-31
################################################################################

getData <- function(Symbol_) {
  
  err0 <- FALSE
  err1 <- FALSE

  tryCatch(  
  
    data1 <- getSymbols(Symbol_, from = from_, to = to_, auto.assign = FALSE),
    
  error = function(e) { err0 <<- TRUE })
  
  if (err0 == TRUE) {
    
    temp <- data.frame(date   = NA, open  = NA, high    = NA, low   = NA, close = NA, 
                       vol    = NA, adj   = NA, comment = "", ret   = NA, index = NA, 
                       ticker = NA, div   = NA, split   = NA, spy   = NA, wti   = NA,
                       yld13  = NA, yld05 = NA, yld10   = NA, yld30 = NA) 
  }
  if (err0 == FALSE) {
    
    tryCatch(
    
      temp  <- list(
        
        data.frame(data1)                                                    %>%
        rename(open    = names(.)[1], high = names(.)[2], low = names(.)[3], 
               close   = names(.)[4], vol  = names(.)[5], adj = names(.)[6]) %>%
        mutate(comment = ifelse(is.na(close), "NA", ""))                     %>%
        fill  (close)                                                        %>%
        mutate(ret     = .[[4]]/lag(.[[4]]))                                 %>%
        mutate(index   = cumprod(c(100, ret[-1])))                           %>%
        mutate(ticker  = Symbol_)                                            %>%
        mutate(date    = as.character(index(data1)))                         %>%
        remove_rownames(),
        
        data.frame(suppressWarnings(getDividends(Symbol_, from = from_)))    %>% 
        rownames_to_column("date")                                           %>%
        rename(div = names(.)[2]),
      
        data.frame(suppressWarnings(getSplits(Symbol_, from = from_)))       %>% 
        rownames_to_column("date")                                           %>%
        rename(split = names(.)[2]),
      
        spy   %>% select(date, spy),
        
        wti   %>% select(date, wti),
        
        yld13 %>% select(date, yld13),
        yld05 %>% select(date, yld05),
        yld10 %>% select(date, yld10),
        yld30 %>% select(date, yld30))                                       %>%               
      
      reduce(left_join, by = "date"),
      
    error = function(e) { err1 <<- TRUE })
  }
  if (err1 == TRUE) {
    
    temp <- data.frame(date   = NA, open  = NA, high    = NA, low   = NA, close = NA, 
                       vol    = NA, adj   = NA, comment = "", ret   = NA, index = NA, 
                       ticker = NA, div   = NA, split   = NA, spy   = NA, wti   = NA,
                       yld13  = NA, yld05 = NA, yld10   = NA, yld30 = NA) 
  }
  if (err1 == FALSE) {
    
    write.csv(temp, paste0("C:\\Users\\kim_t\\Desktop\\data\\history\\", Symbol_, "\\history_", Sys.Date(), ".csv"))
  }
  pdf(file = paste0("C:\\Users\\kim_t\\Desktop\\data\\history\\", Symbol_, "\\plot_", Sys.Date(), ".pdf"))
  plot(temp$index, type = "l", col = "red", ylim = c(0, max(temp$spy, temp$index, na.rm = TRUE)))
  lines(temp$spy, col = "black")
  dev.off();

  return(temp)
}
