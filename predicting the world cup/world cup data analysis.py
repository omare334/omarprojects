import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Read the data from the csv file
df = pd.read_csv('players_fifa23.csv')
#read first five rows
print(df.head())
#read last five rows
print(df.tail())
#read columns
print(df.columns)
#read shape
print(df.shape)
#make new dataframe with LongShots and Agression and Vision
df1 = df[['LongShots','Aggression','Vision']]
print(df1.head())








