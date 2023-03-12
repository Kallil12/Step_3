import random

# list of years to choose from
years = [2021, 2022, 2023]

# list of months to choose from
months = ['{:02d}'.format(i) for i in range(1, 13)]

# list of days to choose from
days = ['{:02d}'.format(i) for i in range(1, 31)]

# list of numbers to choose from
numbers = [str(i) for i in range(901, 913)]

# generate 200 strings
strings = []
for i in range(200):
    year = random.choice(years)
    month = random.choice(months)
    day = random.choice(days)
    number = random.choice(numbers)
    string = "('{}',{})".format('-'.join([str(year), month, day]), number)
    strings.append(string)
    
# print the generated strings
print(strings)