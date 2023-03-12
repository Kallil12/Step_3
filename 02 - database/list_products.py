import random

part_number = ('AstroMech_R2', 'XWing_Turbine', 'TieFighter_ControlModule', 'MilleniumFalcom_LandingGear', 'TieFighter_FlightAssist',
               'AstroMech_R4', 'XWing_LandingGear', 'TieFighter_LandingGear', 'Imperial_Part_01', 'MechanicalArm_Human', 'Respirator_Motor',
               'MechanicalArm_Wookie', 'Combat_Armor', 'Combat_Blaster', 'LightSaber_Crystal_RED', 'LightSaber_Crystal_GREEN', 'LightSaber_Crystal_BLUE',
               'LightSaber_Crystal_WHITE', 'MandalorianBeskar_ChestPlate', 'MandalorianBeskar_Helmet', 'ImperialStation_Computers', 'SpecialBlaster',
               'LandCruiser_Engine', 'PodRacer_Engine', 'PodRacer_Controller', 'AstroMech_R1', 'Astromech_ControlModule', 'Astromech_Battery', 'Armor_Battery',
               'CombatHelmet_Battery')

values = []
for i in range(50):
    value = random.randint(901, 1100)
    part = random.choice(part_number)
    cost = random.randint(100, 100000)
    price = random.randint(50, 250)
    quantity = random.randint(1, 30)
    values.append((value, part, cost, price, quantity))
    
print(values)
