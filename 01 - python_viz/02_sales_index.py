'''
Create a new column called 'Win Ratio', which is given by:

WR = Closed Won/(Closed Won + Closed Lost)

if Closed Lost is very low and Closed Won is high, the total ratio
gets closer to 1, it doesn't mean that the team is necessarily doing
bad if their ratio is lower than another, because it could be a team
that makes a high number of contact, so naturally it will have some
losses in the way, but it is good to be closer to 1.

'''

#import pandas as pd
#import matplotlib.pyplot as plt

#df = pd.read_csv('/content/sample_data/SalesForce.csv')

colors = []
for value in df_closed_grouped['Sale Index']:
    if value < 0.4:
        colors.append('red')
    elif value >= 0.4 and value <= 0.5:
        colors.append('orange')
    else:
        colors.append('blue')

df_closed = df[df['stagename'].isin(['Closed Won', 'Closed Lost'])]

# Calculate the number of Closed Won and Closed Lost opportunities by sales team
df_closed_grouped = df_closed.groupby(['sales_team__c', 'stagename'])['accountid'].count().reset_index()
df_closed_grouped = df_closed_grouped.pivot(index='sales_team__c', columns='stagename', values='accountid').reset_index()
df_closed_grouped.fillna(0, inplace=True)

# Create the Sale Index column
df_closed_grouped['Sale Index'] = df_closed_grouped['Closed Won'] / (df_closed_grouped['Closed Won'] + df_closed_grouped['Closed Lost'])

# Sort the data by Sale Index
df_closed_grouped = df_closed_grouped.sort_values(by='Sale Index')

# Create a horizontal bar chart
plt.figure(figsize=(10,10))
plt.barh(df_closed_grouped['sales_team__c'], df_closed_grouped['Sale Index'])
plt.title('Sale Index by Sales Team')
plt.xlabel('Sale Index')
plt.ylabel('Sales Team')

# Add the values to the bars
for i, v in enumerate(df_closed_grouped['Sale Index']):
    plt.text(v + 0.01, i, str(round(v, 2)), color='blue', fontweight='bold')

plt.show()