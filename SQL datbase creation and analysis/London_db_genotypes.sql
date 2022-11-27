#creation of and use of data base title (London_Paris_DB)(question 1)
CREATE DATABASE London_Paris_DB;
#to use database through 
USE London_Paris_DB;
#creating empty tables with characteristics for the data to be imported(question 2)
#CREATE TABLE <table label> ("column title" <class("constraints for class type")
CREATE TABLE country_ids (country VARCHAR(20),country_name VARCHAR(20), PRIMARY KEY (country));
CREATE TABLE sample_characteristics (sample_id VARCHAR(20),
dob VARCHAR(20),
dor VARCHAR(20),
dod VARCHAR(20),
dodiag VARCHAR(20),
sex INTEGER,cc_status INTEGER,smoke_status INTEGER,
country VARCHAR(20),center VARCHAR(20),vit_status VARCHAR(20),
a_sta_smok DOUBLE(2,0),a_quit_smok DOUBLE(2,0),
age_recr DOUBLE PRECISION,n_cigret_lifetime DOUBLE PRECISION,
PRIMARY KEY (sample_id),
FOREIGN KEY (country) REFERENCES country_ids(country));
CREATE TABLE sample_genotypes (sample_id VARCHAR(20),SNP1 INTEGER,
SNP2 INTEGER, SNP3 INTEGER, SNP4 INTEGER, SNP5 INTEGER
FOREIGN KEY (sample_id) REFERENCES sample_characteristics(sample_id));
alter table sample_genotypes add primary key (sample_id);#used to add (sample_id) as primary key also
#importing the data into the table(question 3)
SET GLOBAL local_infile=1; #unlocks local access through mySQL to data file
#upolading country ids data  into country_ids table 
LOAD DATA LOCAL INFILE 'C:/Users/omare/OneDrive/Documents/HDA/Clinical data managment/coursework/Data/country_ids.csv' INTO TABLE country_ids;
SET GLOBAL local_infile=1;
#EXPLORING THE DATA
#determing amount of records within each table (question 5)
SELECT count(*) FROM sample_characteristics; #1000 records
SELECT count(*) FROM sample_genotypes relation;#500 records
SELECT count(*) FROM country_ids; # 13 records
#code function and purpose discovery (question 6.1)
SELECT SUM(CASE WHEN a_sta_smok IS NULL then 1 ELSE 0 END) as a_sta_smok
FROM sample_characteristics ;#used own data a_sta_smok to deduce fucntion of code
#Function to identify and count number of null values in each column (question 6.2,6.3)
select 
    sum(CASE WHEN dob is null then 1 else 0 end) as dob,
    sum(CASE WHEN dor is null then 1 else 0 end) as dor,
    sum(CASE WHEN dod is null then 1 else 0 end) as dod,
	sum(CASE WHEN dodiag is null then 1 else 0 end) as dodiag,
	sum(CASE WHEN sex is null then 1 else 0 end) as sex,
	sum(CASE WHEN cc_status is null then 1 else 0 end) as cc_status,
    sum(CASE WHEN smoke_status is null then 1 else 0 end) as smoke_status,
    sum(CASE WHEN country is null then 1 else 0 end) as country,
    sum(CASE WHEN center is null then 1 else 0 end) as center,
    sum(CASE WHEN vit_status is null then 1 else 0 end) as vit_status,
    sum(CASE WHEN a_sta_smok is null then 1 else 0 end) as  a_sta_smok,
    sum(CASE WHEN a_quit_smok is null then 1 else 0 end) as a_quit_smok,
    sum(CASE WHEN age_recr is null then 1 else 0 end) as age_recr,
    sum(CASE WHEN n_cigret_lifetime is null then 1 else 0 end) as n_cigret_lifetime
FROM sample_characteristics;
#QUERYING THE DATA 
#creating table for average age of recruitment per country (Question 7.1)
SELECT country_ids.country, country_name , CAST(AVG(age_recr) AS DECIMAL (10,2)) as avg_age_country
FROM country_ids
LEFT JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY country ORDER BY avg_age_country DESC;
#creating table to find number of samples of each country(question 7.2)
SELECT country_ids.country, country_name , count(sample_characteristics.sample_id) as counts
FROM country_ids
LEFT JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY country ORDER BY count(sample_characteristics.sample_id) DESC;
#counting the number of samples in each center (question 7.3)
SELECT center , count(sample_characteristics.sample_id) as counts
FROM sample_characteristics
GROUP BY center ORDER BY count(sample_characteristics.sample_id) ASC;
#youngest age of recruitment with decimals(question 7.4)
SELECT country_name , MIN(sample_characteristics.age_recr) as minimum_age_of_recruitment
FROM country_ids
INNER JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY country_name ORDER BY MIN(sample_characteristics.age_recr) ASC;
#youngest age of recruitment full number ( question 7.4)
SELECT country_name , CAST(MIN(sample_characteristics.age_recr) AS DECIMAL (2,0)) as minimum_age_of_recruitment
FROM country_ids
INNER JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY country_name ORDER BY MIN(sample_characteristics.age_recr) ASC;
#country with the most male samples ( question 7.5)
SELECT country_name,
SUM(CASE WHEN sex = '2' THEN 1 ELSE 0 END) as males_samples
FROM country_ids
INNER JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY country_name ORDER BY males_samples DESC;
#country with the most ditinct centres supplying samples( question 7.6)
SELECT country_name , count( DISTINCT center) as numer_of_distinct_centers
FROM country_ids
INNER JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY country_name ORDER BY numer_of_distinct_centers  DESC;
#country-center pair has the most amount of samples (Question 7.7)
SELECT DISTINCT country_name,center,count(sample_characteristics.sample_id) as number_of_samples
FROM country_ids
INNER JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
GROUP BY center,country_name ORDER BY count(sample_characteristics.sample_id)  DESC;
#CREATING NEW DATA FROM OLD DATA (question 8)
#creating table 
CREATE TABLE sample_char_genotypes
AS SELECT 
sample_characteristics.sample_id,dob,sex,cc_status,age_recr,
sample_characteristics.country,
country_ids.country_name,
SNP1,SNP2,SNP3,SNP4,SNP5
FROM country_ids
INNER JOIN sample_characteristics ON country_ids.country = sample_characteristics.country
INNER JOIN sample_genotypes ON sample_characteristics.sample_id=sample_genotypes.sample_id
