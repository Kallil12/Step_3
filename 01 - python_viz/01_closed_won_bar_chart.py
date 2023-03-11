#import pandas as pd
#import matplotlib.pyplot as plt

# Filter the data to only include 'Closed Lost' opportunities
df_closed_won = df[df['stagename'] == 'Closed Won']

# Count the number of 'Closed Lost' opportunities by sales_team__c
df_closed_won_count = df_closed_won['sales_team__c'].value_counts().reset_index()
df_closed_won_count.columns = ['sales_team__c', 'closed_won_count']

# Create a bar chart
plt.figure(figsize=(15,10))
plt.bar(df_closed_won_count['sales_team__c'], df_closed_won_count['closed_won_count'])
plt.title('Number of Closed Won Opportunities by Sales Team')
plt.xlabel('Sales Team', fontsize = 15)
plt.ylabel('Number of Closed Won Opportunities')

for index, row in df_closed_won_count.iterrows():
    plt.text(index, row['closed_won_count']+1, str(row['closed_won_count']), ha='center',fontsize=15)

plt.xticks(rotation=45)
plt.show()