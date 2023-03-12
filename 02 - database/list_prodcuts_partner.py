import random

part_number = ('Refurbished_AstroMech_R2', 'Refurbished_XWing_Turbine', 'Refurbished_TieFighter_ControlModule', 'Refurbished_MilleniumFalcom_LandingGear', 'Refurbished_TieFighter_FlightAssist', 'Refurbished_AstroMech_R4', 'Refurbished_XWing_LandingGear', 'Refurbished_TieFighter_LandingGear', 'Refurbished_Imperial_Part_01', 'Refurbished_MechanicalArm_Human', 'Refurbished_Respirator_Motor', 'Refurbished_MechanicalArm_Wookie', 'Refurbished_Combat_Armor', 'Refurbished_Combat_Blaster', 'Refurbished_LightSaber_Crystal_RED', 'Refurbished_LightSaber_Crystal_GREEN', 'Refurbished_LightSaber_Crystal_BLUE', 'Refurbished_LightSaber_Crystal_WHITE', 'Refurbished_MandalorianBeskar_ChestPlate', 'Refurbished_MandalorianBeskar_Helmet', 'Refurbished_ImperialStation_Computers', 'Refurbished_SpecialBlaster', 'Refurbished_LandCruiser_Engine', 'Refurbished_PodRacer_Engine', 'Refurbished_PodRacer_Controller', 'Refurbished_AstroMech_R1', 'Refurbished_Astromech_ControlModule', 'Refurbished_Astromech_Battery', 'Refurbished_Armor_Battery', 'Refurbished_CombatHelmet_Battery')

values = []
for i in range(50):
    value = random.randint(901, 1100)
    part = random.choice(part_number)
    cost = random.randint(1, 10)
    price = random.randint(15, 150)
    quantity = random.randint(1, 10)
    values.append((value, part, cost, price, quantity))
    
print(values)
