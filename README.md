# Chess

A command line game built with Ruby, tested with RSpec

## About

Chess is a complex game. The biggest challenge while building this project was organizing the code in a clean modular way. My programming skills are not the same as before building chess. There are many things I would do differently if I were to recreate this project. Building chess was a learning experience for me. I got to see the value of TDD-ing complex features and solving problems using both tests and a debugger together. Thank you to The Odin Project for an amazing curriculum and for inspiring me to take on this project. If you the reader see areas that I can improve on, any feedback is appreciated. I'm always looking to improve my skills.

Full Project Description
https://www.theodinproject.com/lessons/ruby-ruby-final-project

## Reading this Program

Before jumping into the code, I think it would be useful to go over _how this program is structured_. When a `Game` is initialized, a new `Board` is created. This `Board` is a class that contains a hash of `Cell` objects. Depending on the position (`@value`) of the cell, a `Piece` would be created too. The entire `Board` object looks similar to this...

```
Board.cells
 {[0, 0] =>  (Cell Object)
             @bg_color=:light_black,
             @value=[0, 0]
             @piece= (Rook Object)
                     @color=:light_white,
                     @icon="♜",
                     @moved=false,
                     @value=5>,
   ...
   }
```

You can see that a hash is a `key => value` data structure. The key here is the location (`[0, 0]`) and the value is the `Cell` object with it's attributes (and a `Piece` object if included). This hash is composed of **64 cells** representing each cell in an 8 x 8 chess board. I made the decission to organize these cells in a ruby hash because it would be easy traverse in finding legal moves, check, checkmate, stalemate, displaying the board UI, etc... there are many different ways to approach this project. This is just the implementation that worked best for me and my initial thought process.

## Features

**Main**

- Check: _Alerts user if King is under attack_
- Capture: _Removes foe piece if user legaly attacks_
- Grave: _Stores and displays total value of captured pieces_
- Save/Load: _User can save game at any time and resume_
- Exit: _User can exit the game at any time_
- Replay: _If game over, prompts user to play new game or exit_

**Game Over**

- Checkmate: _User is in check and has no legal moves_
- Stalemate: _User has no legal moves_
- Insufficient Material: _Ends game if board contains..._
  - _only kings_
  - _only kings and one knight_
  - _only kings and bishops with the same cell color_

**Special**

- Pawn Jumps: _Pawns can jump 2 cells from initial position (without piece infront of it)_
- En Passant: _Pawns can capture foe pawn if they jump next to user pawn on correct row_
- Promotion: _If user pawn reaches the end of foe side, pawn can promote to Queen, Rook, Bishop, Knight_
- Castling: _Kingside and Queenside_

## How to play

Repl: (Work in Progess)

Copy/Paste in Terminal (must have ruby installed)

```
git@github.com:supersakana/chess.git
cd chess
ruby lib/main.rb
```

The initial program comes with 2 saved files, enter the file number to load or any other key for a new game

A new game will prompt the user to input names for Player 1 and 2

Enter a start and landing position (a2a3) to make a move

NOTE: This move gets converted into a key **(a2a3 => [[0, 1], [0, 2]])** so the program can traverse through the cells/hash

Players can save `s` or exit `e` at any point in the game

The game will continue until a game over condition is met

## Feedback

If there are any bugs, issues, or general ways this program can be improved, please feel free to create an issue or contact me directly at zacwilliamson@icloud.com
