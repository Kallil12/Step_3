#import pandas as pd
#import matplotlib.pyplot as plt

#df = pd.read_csv('/content/sample_data/SalesForce.csv')

# Filter the data based on the conditions
filter_condition = df['sales_team__c'] == 'HS 1'
filter_condition &= df['stagename'].isin(['Closed Won', 'Closed Lost', 'Closing Stage'])
filtered_data = df.loc[filter_condition]

# Group the data by ownerid and stagename
grouped_data = filtered_data.groupby(['ownerid', 'stagename']).size().reset_index(name='count')

# Pivot the data to get a table with ownerid as the index, stagename as columns, and count as values
pivoted_data = grouped_data.pivot(index='ownerid', columns='stagename', values='count').fillna(0)

# Add a total column to the pivoted data
pivoted_data['Total'] = pivoted_data.sum(axis=1)

# Calculate the sales_index column as Closed Won / (Closed Won + Closed Lost)
pivoted_data['sales_index'] = pivoted_data['Closed Won'] / (pivoted_data['Closed Won'] + pivoted_data['Closed Lost'])

# Sort the pivoted data by the Total column in descending order
sorted_pivoted_data = pivoted_data.sort_values('Total', ascending=False)

# Print the sorted pivoted data
print(sorted_pivoted_data[['Closed Won', 'Closed Lost', 'sales_index']])
