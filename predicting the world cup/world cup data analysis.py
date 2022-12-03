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
#plot histogram for all collumns using matplotlib
import matplotlib.pyplot as plt
plt.hist(df['Overall'], bins=10)
plt.show()
#qqplot for all collumns using matplotlib
import matplotlib.pyplot as plt
import scipy.stats as stats
stats.probplot(df['Overall'], dist="norm", plot=plt)
plt.show()
#boxplot for all collumns using matplotlib
import matplotlib.pyplot as plt
plt.boxplot(df['Overall'])
plt.show()







