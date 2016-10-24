import random

n = 10

print("strategy 1")
s1_points = 0
for i in range(100000):
    num1 = random.randint(1,n)
    num2 = num1
    while num2==num1:
        num2 = random.randint(1,n)
    choice = random.randint(1,2)
    if choice == 1:
            if num1 > num2:
                s1_points = s1_points +1
    if choice == 2:
            if num2 > num1:
                s1_points = s1_points +1
print("points",s1_points)

print("strategy 2")
s2_points = 0
for i in range(100000):
    num1 = random.randint(1,n)
    num2 = num1
    while num2==num1:
        num2 = random.randint(1,n)
    num3 = random.randint(1,n)
    choice = random.randint(1,2)
    if choice == 1:
        if num3 > num1:
            if num2 > num1:
                s2_points = s2_points + 1
        elif num1 > num2:
            s2_points = s2_points +1
    if choice == 2:
        if num3 > num2:
            if num1 > num2:
                s2_points = s2_points + 1
                
        elif num2 > num1:
            s2_points = s2_points + 1
        
        
print("points",s2_points)
