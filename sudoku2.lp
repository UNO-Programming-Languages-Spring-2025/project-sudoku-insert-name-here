% Sudoku Solver
%
% Hints:
% For subgrid of size n, subgrids can be identified by labels 1..n*n
% A cell (x,y) can be mapped to the subgrid labeled 1+(((x-1)/n)*n+(y-1)/n)

% Your implementation please...
% Define the 9x9 grid.
row(1..9).
col(1..9).
val(1..9).

n(3).

% Define a subgrid as given in the hints
subgrid(R, C, S) :- row(R), col(C), n(N), S = 1 + (((R-1)/N)*N + (C-1)/N).

% basically fills in our new sudoku with the premade values by saying that positions in new sudoku match the provided ones
sudoku(R, C, V) :- initial(R, C, V).

% Each cell must have only once number (similar to the color graph example in class: { assign(N,C) : color(C) } = 1 :- node(N).)
% Attempt to assign a Value at position (R, C) only if that (R, C) location was not already in the initial
1 { sudoku(R, C, V) : val(V) } 1 :- row(R), col(C), not initial(R, C, _).

% Each number appears only once per row.
:- sudoku(R, C1, V), sudoku(R, C2, V), C1 != C2.

% Each number appears only once per column.
:- sudoku(R1, C, V), sudoku(R2, C, V), R1 != R2.

% New Constraint: Value V cannot appear more than once in a subgrid
:- sudoku(R1, C1, V), sudoku(R2, C2, V), subgrid(R1, C1, S), subgrid(R2, C2, S), (R1, C1) != (R2, C2).
% Constraint breakdown: 2 different locations (R1, C1) and (R2, C2) are within the same subgrid. If the values (V) at (R1, C1) and (R2, C2) are the same, that solution is invalid

% Show the final Sudoku solution.
#show sudoku/3.