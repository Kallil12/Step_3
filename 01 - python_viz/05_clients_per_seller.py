#import pandas as pd
#import matplotlib.pyplot as plt

#df = pd.read_csv('/content/sample_data/SalesForce.csv')

# Filter the data for sales_team__c == 'Strategic Sales'
strategic_sales_data = df[df['sales_team__c'] == 'Strategic Sales']

# Group the data by ownerid and count the number of unique accountids associated with each ownerid
ownerid_count = strategic_sales_data.groupby('ownerid')['accountid'].nunique()
ownerid_cout = ownerid_count.sort_values()

'''
s.plot(kind='bar')

# add axis labels and a title
plt.xlabel('Fruit')
plt.ylabel('Quantity')
plt.title('Fruit Quantities')

# show the plot
plt.show()
'''

ownerid_count.plot(kind = 'bar')

print(ownerid_count)