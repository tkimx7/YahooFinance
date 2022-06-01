############################################################################################################
###### --- README --- ######################################################################################
############################################################################################################
# 
# --- I publish here a sample method of importing and processing data for some 16,000 stocks (as of Jun1, 2022) 
# --- from Yahoo Finance via a parallel method in R. For readability purposes, the method's divided into a 
# --- "header" file for all function declarations and a "getter" file to run these declarations in a parallel 
# --- fashion. For every data frame for each ticker imported from Yahoo Finance, it standardizes all prices 
# --- into an index starting at 100 (see the "indexConstruction" repository to learn the fundamentals of 
# --- building an index. Essentially, all stock price levels must be standardized to start at 100 for 
# --- comparability purposes). In addition to stock prices, there are standardized prices for the S&P 500 index,
# --- the crude oil index and the treasury yield indices for t-bills, notes and bonds. These serve as 
# --- stastically significant independent variables for stock prediction models. I do not share the prediction 
# --- model itself as it's proprietary.
#
# --- The results of this method are the stock price history and ggplot visual dashboards for each and every
# --- ticker.
#
# --- This parallel method reduces the time of sequentially importing and processing data from 5 hours to 
# --- 0.5 hours. It works for no more than 4 cores. Registering more cores significantly increases overhead 
# --- thereby decreasing performance, and in addition carries the risk of failing to import data due to 
# --- excessive API calls.
#
# --- This was fully functional until April 29, 2022 when it seems Yahoo Finance limited API calls, making 
# --- parallel import impossible. I'm trying to build a wrapper to fix this, but given that even the creator 
# --- of the "quantmod" library that's responsible for the API is having trouble, this will take significant
# --- effort before resuming normal operations.
