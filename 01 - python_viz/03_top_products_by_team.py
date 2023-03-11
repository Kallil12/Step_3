#import pandas as pd
#import matplotlib.pyplot as plt

#df = pd.read_csv('/content/sample_data/SalesForce.csv')

# Filter the data based on the conditions
filter_condition = df['stagename'] == 'Closed Won'
filter_condition &= df['primary_application__c'].notnull()
filter_condition &= df['sales_team__c'].isin(['Strategic Sales', 'HVS 3', 'HVS 1'])
filtered_data = df.loc[filter_condition]

# Group the data by sales team and primary application
grouped_data = filtered_data.groupby(['sales_team__c', 'primary_application__c'])['amount'].sum()

# Create pie charts for each sales team
sales_teams = ['Strategic Sales', 'HVS 3', 'HVS 1']
for team in sales_teams:
    team_data = grouped_data.loc[team]
    team_data = team_data.sort_values(ascending=False)
    other_products_amount = team_data.iloc[5:].sum()
    top_5_data = team_data.iloc[:5]
    top_5_data['Other Products'] = other_products_amount
    top_5_data.plot(kind='pie', autopct='%1.1f%%', startangle=90)
    plt.title(f"Top 5 Primary Applications Sold by {team}")
    plt.ylabel('')
    plt.figure(figsize=(20,10))
    plt.show()