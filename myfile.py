#!/bin/python


a = 1
b = 3
if a > b:
    print("a is Greater")
else:
    print("b is Greater")

# Sample Board where: 
# 0 = Empty tile
# 1 = Coin
# 2 = Enemy
# 3 = Goal
board = [[0, 0, 1],
         [0, 2, 0],
         [1, 0, 3]]
