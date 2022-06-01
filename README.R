############################################################################################################
###### --- README --- ######################################################################################
############################################################################################################
# 
# --- I publish here a sample method of importing and processing data for some 18,000 stocks from Yahoo Finance 
# --- via a parallel method in R. For readability purposes, the method's divided into a "header" file for all 
# --- function declarations and a "getter" file to run these declarations in a parallel fashion. For every 
# --- data frame for each ticker imported from Yahoo Finance, it standardizes all prices into a index starting
# --- at 100 (see the "indexConstruction" repository for the fundamentals of building an index). This data 
# --- frame is then appended to other 
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
