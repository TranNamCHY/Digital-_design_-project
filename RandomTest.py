import random
import os
# Generate a random integer between -128 and 127

# Specify the file name
file_name = r'E:/Digital_Design__Project/test.dat'
max = -128
min = 127
# Write the random value to the file
with open(file_name, "w+") as file:
    for i in range(0,255):
        random_value = random.randint(-128, 127)
        if max < random_value:
            max = random_value
        if min > random_value:
            min = random_value
        file.write(f"{random_value}\n")
print("Max: "+str(max)+" Min: "+str(min)+" Max diff: "+str(max-min))

