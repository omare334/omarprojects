#this function helps to find the largers binary gap within the binary representation of a number
def solution(N):
    num = binary = format(N, "06b")
    char = str(num)
    find = False
    result, conteur = 0, 0

    for c in char:
        if c == '1' and not find:
            find = True

        if find and c == '0':
            conteur += 1

        if c == '1':
            if result < conteur:
                result = conteur
            conteur = 0

    return result
#function that rotates an array to the right by a given number of steps
def solution(A, K):
    if len(A) == 0:
        return A
    for i in range(K):
        A.insert(0, A.pop())
    return A
#doing it thorugh numpy
import numpy as np


def solution(A, K):
    df = np.array(A)
    g=np.roll(df, K)
    return (g)


print(solution([1, 2, 3, 4, 5], 2))
#also can use this
def solution(A):
    A=sorted(A)
    return abs(sum(A[::2])-sum(A[1::2]))
#find smallest positive integer that does not occur in a given sequence
def solution(A):
    A = set(A)
    for i in range(1, len(A) + 2):
        if i not in A:
            return i
#findig samllest positive integer that does not occur in a given sequence
def solution(A):  # Our original array

    m = max(A)  # Storing maximum value
    if m < 1:
        # In case all values in our array are negative
        return 1
    if len(A) == 1:
        # If it contains only one element
        return 2 if A[0] == 1 else 1
    l = [0] * m
    for i in range(len(A)):
        if A[i] > 0:
            if l[A[i] - 1] != 1:
                # Changing the value status at the index of our list
                l[A[i] - 1] = 1
    for i in range(len(l)):

        # Encountering first 0, i.e, the element with least value
        if l[i] == 0:
            return i + 1
            # In case all values are filled between 1 and m
    return i + 2


