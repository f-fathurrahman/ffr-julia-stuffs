from time import time

start_time = time()
def euclidian_algorithm_division_count(a, b):
    division_count = 1
    if b > a:
        a, b = b, a
    c = a % b
    while c != 0:
        a, b = b, c
        division_count += 1
        c = a % b
    return division_count


N = 10**30
M = 10**4
from random import randint
division_count_array = []
while M > 0:
    a = randint(1, N)
    b = randint(1, N)
    division_count_array.append(euclidian_algorithm_division_count(a, b))
    M -= 1
print(time() - start_time, "seconds")