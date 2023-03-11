#import pandas as pd
#import matplotlib.pyplot as plt

#df = pd.read_csv('/content/sample_data/SalesForce.csv')

df['opportunity_creation_date__c'] = pd.to_datetime(df['opportunity_creation_date__c'])
df['closedate'] = pd.to_datetime(df['closedate'])

# Filter to only include rows where stagename is 'Closed Won'
df_closed_won = df[df['stagename'] == 'Closed Won']

# Calculate the difference in days between closedate and opportunity_creation_date__c
df_closed_won['days_to_close'] = (df_closed_won['closedate'] - df_closed_won['opportunity_creation_date__c']).dt.days

# Group by sales_team__c and calculate the mean of days_to_close for each group
df_mean_days_to_close = df_closed_won.groupby('sales_team__c')['days_to_close'].mean().reset_index()
df_mean_days_to_close = df_mean_days_to_close.sort_values('days_to_close')


# Sort the groups in ascending order of the mean values and get the top 3 teams
#df_top_3_teams = df_mean_days_to_close.sort_values('days_to_close').head(3)

# Print the results
print(df_mean_days_to_close)