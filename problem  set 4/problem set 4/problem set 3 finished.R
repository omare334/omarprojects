 library(readr)
 neutron <- read_csv("~/OneDrive/Documents/HDA/Introduction to statistical thinking/Week 4/problem  set 4/neutron.csv")

# estimating prob  --------------------------------------------------------


#Estimate the probability of death within one year of cancer diagnosis (assuming that the treatment
#has no effect on survival) and calculate the 95% confidence interval for the probability.
prop.table(table(neutron$death1year))
prop.table(table(neutron$death1year))["Yes"]
#function 
probability<- function(col){
  colprop<- prop.table(table(col))
  return(colprop)
}
probability(neutron$death1year)

# confidence interval  ----------------------------------------------------
#exploring possibility of a function
as.factor(neutron$death1year)
neutorontable<-table(neutron$death1year)
neutorontable
table1<-table(neutorontable)
table1_df<-data.frame(table1)
table1_df[1,1]
table1_df[2,1]
length(neutron$death1year)
CI_binomial_NO<- function(df){
  table<-df %>% table() %>% data.frame ()
  ci<-prop.test(x= table [1,2], n=(length(df)), conf.level=.95, correct=FALSE)
  return(ci)
} 
CI_binomial_Yes<- function(df){
  table<-df %>% table() %>% data.frame ()
  ci<-prop.test(x= table [2,2], n=(length(df)), conf.level=.95, correct=FALSE)
  return(ci)
}

CI_binomial<- function(df, die){
  ci <- NULL
  if(die) {
    table<-df %>% table() %>% data.frame ()
    ci<-prop.test(x= table [2,2], n=(length(df)), conf.level=.95, correct=FALSE)
  } else {
    table<-df %>% table() %>% data.frame ()
    ci<-prop.test(x= table [1,2], n=(length(df)), conf.level=.95, correct=FALSE)
  }
  return(ci)
} 
#confirm it works
CI_binomial_Yes(neutron$death1year)
CI_binomial(neutron$death1year, F)
CI_binomial(neutron$death1year)




# porbability of death1year below 60% -------------------------------------
# h0 :probability of death1 year >=60
# h1: probability of death <60
binom.test(82,154,0.6, alternative="less")


# continuitu correction ---------------------------------------------------
binom.test(82,154,0.6, alternative="less", correct = TRUE)

#no differnece


# if is exactly 60% -------------------------------------------------------
pbinom(82, size=154, prob=0.6)

# contingency table  ------------------------------------------------------
p<-table(neutron$treatment,neutron$death1year)
#proprotions
H<-prop.table(table(neutron$treatment,neutron$death1year))

# B2 Estimate the risk difference, risk ratio, and odds ratio and  --------
#risk difference 

# risk difference ---------------------------------------------------------


risk_dif<-function(x,y){
  t<-table(x,y) %>% data.frame ()
  a<-t[3,3]
  b<-t[4,3]
  no<-t[1,3]+t[3,3]
  n1<-t[2,3]+t[4,3]
  exposed<-riskdifference(a, b, no, n1, CRC=TRUE, conf.level=0.95)
  return(exposed)
}
risk_dif(neutron$treatment,neutron$death1year)
#interpret: there is a 10% greater chance that you will die 
#when using neutrons as oppose to photons 

# risk ratio  -------------------------------------------------------------
riskratio.wald(p, y = NULL,
               conf.level = 0.95,
               rev = c("neither"),
               correction = FALSE,
               verbose = TRUE)
(1-.8119294)*100=18.8%# decrease in risk you will die 






# odds ratio  -------------------------------------------------------------
oddsratio(p, y = NULL,
          method = c("midp"),
          conf.level = 0.95,
          rev = c("neither"),
          correction = FALSE,
          verbose = FALSE)
#odds of dieing from phton is 0.36 times less chance lowe that you will die from photons


# hypothesis and z stat ---------------------------------------------------

#b2c
#no odds ratio : the odds are equal to 0
#no risk ratio : the risk is equal to 0
#no risk difference there is 0 risk differnece 
# I would use the risk ratio as it looks a the proprotion of exposure as a whole 

# expected value for the contingency table in a ---------------------------
matric<-data.frame(p)
matric
Z<-chisq.test(p, y = NULL, correct = FALSE,
           p = rep(1/length(x), length(x)), rescale.p = FALSE,
           simulate.p.value = FALSE, B = 2000)
Z$observed
Z$expected
#p.chisq
pchisq(H, 1, ncp = 1, lower.tail = TRUE, log.p = FALSE)

# looking at corrected p value  -------------------------------------------
corrected_Z<-chisq.test(p, y = NULL, correct = TRUE,
                          p = rep(1/length(x), length(x)), rescale.p = FALSE,
                          simulate.p.value = FALSE, B = 2000)
corrected_Z

# making tablle for meta 1 year  ------------------------------------------
meta1year<- ifelse(neutron$meta =="Yes" & neutron$metatime <=365,"MYes","MNo")
meta1year
neutron_meta<-cbind(neutron,meta1year)

# contingency table for meta1year and death1year --------------------------------------
table(neutron_meta$meta1year,neutron_meta$death1year)
risk_dif(neutron_meta$meta1year,neutron_meta$death1year)
meta_death<-table(neutron_meta$meta1year,neutron_meta$death1year)

# risk difference , RR, OR ------------------------------------------------
#risk diffence 
risk_dif(neutron_meta$meta1year,neutron_meta$death1year)
#risk ratio 
riskratio.wald(meta_death, y = NULL,
               conf.level = 0.95,
               rev = c("neither"),
               correction = FALSE,
               verbose = TRUE)
#odds ratio 
oddsratio(meta_death, y = NULL,
          method = c("midp"),
          conf.level = 0.95,
          rev = c("neither"),
          correction = FALSE,
          verbose = FALSE)
