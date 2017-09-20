# KnightsPath
This is algorithm to find knights path from source to destination chessboard position

**Problem**: predict top 10 paths for a knight to travel from start chessboard position to destination chessboard position.

Following are the steps for solving the problem:
1.	First define (x,y) coordinates for the chessboard locations. So for a 8*8 chessboard
x and y are defined as having values from 1 to 8. 
2.	Next we will write equations in x and y to simulate the movement of knight. So for vertical movement the equation is: (x+/-1),(y+/-2). For horizontal movement of knight the equation would be: (x+/-2),(y+/-1)
3.	 let's for example take point (x,y) = (3,3), the possible next moves are:
(x+/-1, y+/-2):
(x+1,y+2) = (4,5)
(x+1,y-2) = (4,1)
(x-1,y+2) = (2,5)
(x-1,y-2) = (2,1)
(x+/-2, y+/-1):
(x+2,y+1) = (5,4)
(x+2,y-1) = (5,2)
(x-2,y+1) = (1,4)
(x-2,y-1) = (1,2)

4.	Based on the possible moves depicted by equation above and the constraint that 0<x<9 and 0<y<9 (for 8*8) chessboard, the following algorithm will be followed for searching paths.

•	Define list with start position.
•	Calculate next set of points based on above equations.
•	Check if any of the positions match given destination coordinates. If yes then store as possible path. If No then add position coordinates to the original list.
•	Pick the next position on list and continue with above 3 steps till 10 paths have been found.

The Algorithm is implemented in R for simplicity; the logic is defined with following variables and functions:
XStart,YStart : the start position coordinates.
XDest,YDest: the destination position coordinates. 
NextSteps: data table with columns X and Y to store the x and y coordinates of chessboard position, Linked Source column to store the row number for the origination chessboard position from where the move was made.
DestinationPaths: data table with column to store the PathID(which is the number of path found) and the LinkedSource column which stores the row number of the NextSteps coordinates from where the move was mode.
FindPossiblePaths: is the wrapper function to take input as source ,destination coordinates and dimension of chessboard  and prints out the 10 possible paths.
NextPos: is the function which calculates next possible chessboard positions based on input coordinates.
UpdateList: this function adds to DestinationPaths if the next position matches with the destination coordinates else it adds the coordinates to the NextSteps list.
getPath: this function takes LinkedSource (row number) value from DestinationPaths table and recursively finds the coordinates for the entire path followed.
I have used data.table as it is more efficient than data frames.
