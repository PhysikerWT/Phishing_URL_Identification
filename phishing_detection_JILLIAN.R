setwd("C:/Users/jhern/Desktop/PROJECT")


# Required Packages
# install.packages("ggplot2")
# install.packages("gridExtra")
library(ggplot2)
library(gridExtra)

#Loading in the data
mysmalldata <- read.csv("rawDataSetSmall.csv")
myrawdata <- read.csv("rawDataSet.csv", stringsAsFactors = F)

# Renaming data according to provided paper.
data_names <- c("id","having_IP_address","URL_Length","Shortining_Service","having_At_Symbol",
                "double_slash_redirecting","Prefix_Suffix","having_Sub_Domain","SSLfinal_State",
                "Domain_registration_length","Favicon","Port","HTTPS_token","Request_URL",
                "URL_of_Anchor","Links_in_tags","SFH","Submitting_to_email","Abnormal_URL",
                "Redirect","on_mouseover","RightClick","popUpWindow","Iframe","age_of_domain",
                "DNSRecord","web_traffic","Page_Rank","Google_Index","Links_pointing_to_page",
                "Statistical_report","Result")

names(mysmalldata) <- data_names
names(myrawdata) <- data_names

# Creating functions to clean the data.

# Function that removes all non-existance result rows
clean_results <- function(df) {
  does_exist <- c()
  i <- 1
  while (i <= (nrow(df))) {
    if (is.na(df[i,ncol(df)])) {
      does_exist[i] <- F
    } else {
      does_exist[i] <- T
    }
    i <- i + 1
  }
  return(df[does_exist,])
}

# Function that replaces all NA's with zeros
replace_zero <- function(df) {
  i <- 2
  while (i <= (ncol(df)-1)) {
    j <- 1
    while (j<= nrow(df[i])) {
      if (is.na(df[[i]][j])) {
        df[[i]][j] <- 0
      }
      j <- j + 1
    }
    i <- i + 1
  }
  return(df)
}

#Randomly generates either a 1 or -1
set<-c(-1,1)
replace_random <- function(df) {
  i <- 2
  while (i <= (ncol(df)-1)) {
    j <- 1
     while (j<= nrow(df[i])) {
      if (is.na(df[[i]][j])) {
        value<-sample(set,1)
        df[[i]][j] <- value
      }
      j <- j + 1
    }
    i <- i + 1
  }
  return(df)
}

#Randomly generates either a -1,0,1
set0<-c(-1,0,1)
replace_random_withzero <- function(df) {
  i <- 2
  while (i <= (ncol(df)-1)) {
    j <- 1
    while (j<= nrow(df[i])) {
      if (is.na(df[[i]][j])) {
        value<-sample(set0,1)
        df[[i]][j] <- value
      }
      j <- j + 1
    }
    i <- i + 1
  }
  return(df)
}


binomial
# Using a low ranking value to determine what 1 and -1 represents.
hist(mysmalldata$having_At_Symbol, main="Having @ symbol")
# 1 represents phishing, -1 represents ligitimate and 0 represents suspicous.

# Getting datasets
small_cleaned_results <- clean_results(mysmalldata)
small_cleaned_zeros<- replace_zero(small_cleaned_results)
small_cleaned_random <- replace_random(small_cleaned_results)
small_cleaned_random0 <- replace_random_withzero(small_cleaned_results)


# Plotting information with clean zeros
p1 <- ggplot(small_cleaned_zeros, aes(x=Request_URL, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Are Objects like images loaded from the same domain?")

p2 <- ggplot(small_cleaned_zeros, aes(x=age_of_domain, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the age of the domain greater than 2 years?")

p3 <- ggplot(small_cleaned_zeros, aes(x=SSLfinal_State, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the final state HTTPS?")

p4 <-ggplot(small_cleaned_zeros, aes(x=Statistical_report, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the website rank less than 100,000")

grid.arrange(p1,p2,p3,p4, nrow=2)


# Plotting information with clean random 1 or -1 ONLY
p1 <- ggplot(small_cleaned_random, aes(x=Request_URL, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Are Objects like images loaded from the same domain?")

p2 <- ggplot(small_cleaned_random, aes(x=age_of_domain, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the age of the domain greater than 2 years?")

p3 <- ggplot(small_cleaned_random, aes(x=SSLfinal_State, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the final state HTTPS?")

p4 <-ggplot(small_cleaned_random, aes(x=Statistical_report, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the website rank less than 100,000")

grid.arrange(p1,p2,p3,p4, nrow=2)


# Plotting information with clean random -1,0, 1 ONLY
p1 <- ggplot(small_cleaned_random0, aes(x=Request_URL, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Are Objects like images loaded from the same domain?")

p2 <- ggplot(small_cleaned_random0, aes(x=age_of_domain, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the age of the domain greater than 2 years?")

p3 <- ggplot(small_cleaned_random0, aes(x=SSLfinal_State, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the final state HTTPS?")

p4 <-ggplot(small_cleaned_random0, aes(x=Statistical_report, color=factor(Result), fill=factor(Result))) +
  geom_histogram(bins=3) +
  ggtitle("Is the website rank less than 100,000")

grid.arrange(p1,p2,p3,p4, nrow=2)


