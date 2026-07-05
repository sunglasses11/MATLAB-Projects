% Sarah Burnette
% seburne2@ncsu.edu
% March 5th, 2024
% Lab Section 209
% Project 2: Minesweeper, Spring 2024
clc; clear; close('all');

% Housekeeping

% A player board is made so that the user may keep up with input via the
% command window.

playerBoard = zeros(10) + 11;

% A 10 x 10 solution board is generated

solBoard = genSolutionBoard(10,10);
numMines = numel(solBoard(solBoard == 9));

% The player board is delivered to the figure window via the provided
% function "displayBoard" to reflect the player's moves in a Minesweeper
% graphic.

displayBoard(playerBoard);

% Student-developed function, "isItAWin" defined by variable, "win",
% to test if the game has been won by
% reconciling the the number of unrevealed squares on the
% board (marked by 11s on the player board) and the number of flagged
% squares on the board (marked by 12s on the player board) with the number
% of mines, numMines, marked by 9s on the solution board.

win = isItAWin(playerBoard,numMines);



%%% Enter Game


% The player is welcomed to the game.

fprintf('***************************************\n  Welcome to the Minesweeper Game!\n***************************************\n');


% A while loop is implemented to keep the game alive while the player has
% not yet won.



while win == false


    % variables "row" and "col" are created for row and column,
    % respectively, followed by the variable, "valid" to test if the input
    % for "row" and "col" is valid input via the student-created function,
    % "validateSquare"


    row = input('\nChoose row: ');
    col = input('Choose col: ');

    % Function objective for "validateSquare(row,col, playerBoard)" is detailed in the
    % file, "validateSquare.m"

    valid = validateSquare(row, col, playerBoard);

    % "while" loop to ensure that while the input for either "row" or "col"
    % is out-of-bounds, either by being negative or off the bard, the user
    % will be prompted to enter new input for both variables until both
    % satisfy the condition for being valid.


    while valid == false

        fprintf('Wrong Coordinates OR square has already been revealed! Try again.\n');
        row = input('\nChoose row: ');
        col = input('Choose col: ');

        % Update, "valid" to exit the loop

        valid = validateSquare(row,col,playerBoard);
    end

    % If the input for variable "valid" does meet the requirements for
    % being in bounds, the following code applies.


    if valid == true


        % The following code, that is commented out, is a "safe click" loop to ensure
        % that the user does not select a square with a mine in it on the
        % first click.

        % while numel(playerBoard(playerBoard == 11)) == 100 && solBoard(row,col) == 9
        %  solBoard = genSolutionBoard(10,10);
        % end

        % Variable "pChoi" is created to facilitate the decision process
        % regarding what to do with the selected square. Reveal -- the
        % first option (1) will reveal the square, the second option (2)
        % will flag it and the third option (3) will unflag only a square
        % that had been previously flagged.

        pChoi = input('Reveal(1), Flag-as-a-Mine(2) or Unflag(3): ');

        % A "while" loop to ensure that the player does not select an
        % option other than 1,2, or 3 (assuming that the player only inputs
        % an integer. If the player enters input that is not valid,
        % "Incorrect input. Try again." will print to the command window
        % and the loop will keep going until the player enters a valid
        % option.

        while pChoi < 1 || pChoi > 3

            fprintf('Incorrect input. Try again. \n');
            pChoi = input('Reveal(1), Flag-as-a-Mine(2) or Unflag(3): ');

        end

        % Variable "mineSq" created to check if there is a mine in the
        % selected square via student-created function,
        % "isMineInSquare(solBoard,row,col); function objective is detailed
        % in "isMineInSquare.m" file.

        mineSq = isMineInSquare(solBoard,row,col);

        % Variable "numMines" created to count how many mines there are on
        % the solution board. This variable is then used as input into the
        % "isItAWin" function to determine if the player has won the game.

        numMines = numel(solBoard(solBoard == 9));

        % "if/else" statement to follow. "if" variable "pChoi" is equal to
        % the first selection (1) where the player should decide to reveal
        % the square, one of the following code options will take place.

        if pChoi == 1

            % First, the playerBoard will update to reveal the adjacent
            % squares of the selected square.

            playerBoard = revealAdjSquares(playerBoard,solBoard,row,col);


            % Variable "win" is updated to check to see if after the
            % playerBoard has been updated that the player has won the
            % game.

            win = isItAWin(playerBoard,numMines);

            % Nested "if/else" statement to follow selection of choice 1.


            % "if" variable "mineSq" returns true, this means that
            % after the player selected to reveal the square, a mine
            % was sitting in that spot. The player board is updated to
            % reflect a "13" so that the "displayBoard" function will
            % translate an exploded, red, square to the graphic.

            if mineSq == true

                playerBoard(row,col) = 13;


                % Modify solution board to reflect a "13" in the exploded
                % square so that "displayBoard" command will hold the red
                % color for the singular "bad move"

                solBoard(row,col) = 13;
                displayBoard(solBoard);

                % Print to the command window that the mine has exploded


                fprintf('*******************************************\nA mine has exploded! GAME OVER!\n*******************************************\n');

                % Provided function "displayBoard()" to display the board in the Minesweeper graphic


                % variable "again" to prompt the user for input by asking
                % if they would like to play the game again (1) or if they
                % would like to exit the game (2).


                again = input('Do you want to play again? Yes(1), No(2): ');

                % "while" loop to ensure that while the player selects
                % valid input (assuming the player inputs a number other than one or
                % two), the command window prints "Incorrect Input" until
                % the user enters valid input.


                while again > 2 || again < 1
                    fprintf('Incorrect Input. Try again.\n')
                    again = input('Do you want to play again? Yes(1), No(2): ');
                end

                % If the player enters "2" for "No", "OK, Thanks For
                % playing! GoodBye!" is printed to the command window and
                % the variable "win" is updated to equal "true" to keep the
                % player from re-entering the loop/game.

                if again == 2

                    fprintf('\n\nOK, Thanks For Playing! GoodBye!\n');


                    % The variable "win" is updated to exit the loop should
                    % the player select option (2) to not play again.

                    win = true;

                    % "else" if the player selects the option, "1" for
                    % "Yes" to play the game again, then a "New Game"
                    % message is printed to the command window and a new
                    % solution board is created along with a brand new
                    % player board, size 10 x 10 filled with "11s" for all
                    % unrevealed squares.

                elseif again == 1

                    fprintf('\n******************************************\nGreat. New game begins.\n******************************************\n');
                    solBoard = genSolutionBoard(10,10);
                    playerBoard = zeros(10) + 11;

                    % "displayBoard" function translates the player board
                    % in the command window to the Minesweeper graphic in
                    % the figure window.

                    displayBoard(playerBoard);
                end

                % If the player has won the game, the following code
                % applies.

            elseif win == true


                fprintf('***********************************************\nCongratulations! You won the game!\n***********************************************\n');

                % Variable "over" created to ask the user if they would
                % like to play the game again, given options 1 for "Yes"
                % and 2 for "No"

                over = input('Do you want to play again? Yes(1), No(2): ');

                % "while" loop to ensure that while the player selects
                % valid input (assuming the player inputs a number other than one or
                % two), the command window prints "Incorrect Input" until
                % the user enters valid input.


                while over > 2 || over < 1
                    fprintf('Incorrect Input. Try again.\n')
                    over = input('Do you want to play again? Yes(1), No(2): ');
                end

                % Nested "if/else" statement. If variable "over" equates to
                % the selection, "No", then "OK, Thanks for playing!
                % Goodbye! will be printed to the command window.

                if over == 2

                    fprintf('\n\nOK, Thanks for playing! Goodbye!\n');

                    % The variable "win" is updated to exit the loop should
                    % the player select option (2) to not play again.

                    win = true;


                    % If the variable "over" equates to the selection of
                    % "Yes", the game starts over again and re-enters the
                    % loop by way of the new player board being full of "11s"
                    % A new solution board is generated and a new game is printed to the
                    % Minesweeper Graphic figure window with all unrevealed
                    % squares.


                elseif over == 1

                    % Update to variable "win" to re-enter the loop and
                    % play the game again while it is under the condition
                    % that "win" is false to keep it going.

                    win = false;
                    playerBoard = zeros(10) + 11;
                    solBoard = genSolutionBoard(10,10);
                    displayBoard(playerBoard);

                end


                % "elseif" there are no mines in the square and the move is
                % not a win, then the player board will still update and
                % reveal the surrounding squares and is reflected in the
                % Minesweeper graphic.


            elseif mineSq == false && win == false

                playerBoard = revealAdjSquares(playerBoard, solBoard,row,col);
                displayBoard(playerBoard);


            end
        end
    end

    % If the player selects option (2) from "Reveal(1), Flag-as-a-Mine(2)
    % or Unflag(3): ", an "if" statement follows to determine if the move
    % is a win (a win occurs when the number of flagged squares plus the
    % number of unrevealed squares is equal to the number of mines on the
    % board)


    if pChoi == 2


        % First a test will take place to see if there is already a flag in
        % the chosen square. If there is a flag there, the player will be
        % alerted.

        if playerBoard(row,col) == 12

            fprintf('Square has already been flagged.\n');

            % If the square is cleared to be flagged, the player board will
            % update to reflect a flagged square.

        elseif playerBoard(row,col) == 11

            playerBoard(row,col) = 12;

        end


        % Variable "win" is updated after the player makes the selection.

        win = isItAWin(playerBoard,numMines);

        % If variable "win" returns true, this means that the player has
        % won the game and "Congratulations! You won the game!" will be
        % printed to the command window.

        if win == true


            displayBoard(playerBoard);
            fprintf('***********************************************\nCongratulations! You won the game!\n***********************************************\n');

            % Variable over prompts the user if they would like to play the
            % game again.

            over = input('Do you want to play again? Yes(1), No(2): ');

            % "while" loop to ensure that while the player selects
            % valid input (assuming the player inputs a number other than one or
            % two, the command window prints "Incorrect Input" until
            % the user enters valid input.


            while over > 2 || over < 1
                fprintf('Incorrect Input. Try again.\n')
                over = input('Do you want to play again? Yes(1), No(2): ');
            end


            % If the player selects "No" then the variable "win" is updated
            %  to be "true" so that the player may not re-enter the loop/game.
            % "OK, Thanks for playing! Goodbye!" is printed to the command window and the
            % user is not prompted for more input.

            % Nested "if" statement

            if over == 2

                fprintf('\n\nOK, Thanks for playing! Goodbye!\n');

                % The variable "win" is updated to exit the loop should
                % the player select option (2) to not play again.

                win = true;


                % If the player selects option 1 for "yes" then variable
                % "solBoard" is set to equal a newly generated solution
                % board, different from the last. The variable "win" is
                % updated to equal "false." The player re-enters the loop/game
                % and starts the game over with a fresh board and a new
                % player board full of all 11s is generated.

            elseif over == 1

                % Update to the loop to re-enter the game while it is under
                % the condition that "win" is false

                win = false;

                solBoard = genSolutionBoard(10,10);
                playerBoard = zeros(10) + 11;
                displayBoard(playerBoard);

            end

            % If variable "win" returns a logical (0) and the move is not a win,
            % then the player board reflects a "12" in the designated
            % square on the player board, updates, and the graphic shows a
            % flag in the square.


        elseif win == false

            % If the player does not win, nor lose, the board updates to
            % show a flag in the square. The board is displayed in the
            % graphic.

            displayBoard(playerBoard);

        end

        % If the player selects option 3, to unflag the square, the
        % following code checks to see if the square was first already
        % flagged as it cannot unflag an square which previously had no
        % flag.

        % If the player selected a square to be unflagged that wasn't
        % already flagged, "This square was Not flagged as a mine" prints
        % to the command window. The player re-enters the loop.

    elseif pChoi == 3 && playerBoard(row,col) ~= 12

        fprintf('This square was NOT flagged as a mine. \n');

        % If the player selects option 3, to unflag a square that was
        % already flagged, the player board is updated to show that the
        % square is unrevealed

    elseif pChoi == 3 && playerBoard(row,col) == 12

        playerBoard(row,col) = 11;

        % Variable "win" is updated via the function
        % "isItAWin" to re-calculate the number of now empty squares and
        % compare them against the number of mines and flagged squares on
        % the board.

        win = isItAWin(playerBoard,numMines);
        displayBoard(playerBoard);


        % "if" variable "win" returns true, this means that the player has
        % won the game and "Congratulations! You won the game!" will be
        % printed to the command window.


        if win == true

            fprintf('***********************************************\nCongratulations! You won the game!\n***********************************************\n');

            % Variable over prompts the user if they would like to play the
            % game again.

            over = input('Do you want to play again? Yes(1), No(2): ');


            % "while" loop to ensure that while the player selects
            % valid input (assuming the player inputs a number other than one or
            % two), the command window prints "Incorrect Input" until
            % the user enters valid input.


            while over > 2 || over < 1
                fprintf('Incorrect Input. Try again.\n')
                over = input('Do you want to play again? Yes(1), No(2): ');
            end


            % If the player selects "No" (2) then the varaible "win"
            % is updated to equal "true", exiting the loop. "OK, Thanks for
            % playing! Goodbye!" is printed to the command window and the
            % user is not prompted for more input.

            if over == 2

                fprintf('\n\nOK, Thanks for playing! Goodbye!\n');

                % The variable "win" is updated to exit the loop should
                % the player select option (2) to not play again.

                win = true;


                % If the player selects option 1 for "yes" then variable
                % "solBoard" is set to equal a newly generated solution
                % board, different from the last. This re-enters the loop
                % and starts the game over with a fresh board and a new
                % player board full of all 11s is printed to the command
                % window.

            elseif over == 1

                solBoard = genSolutionBoard(10,10);
                playerBoard = zeros(10) + 11;

            end

            % "elseif" the player did not win the game after selecting to
            % unflag a square, the player board is updated to show an 11 in
            % place of the 12 which is then reflected in the Minesweeper
            % graphic via provided "displayBoard" function. The graphic
            % removes the flag and the square is unrevealed.


        end

    end
end




























            
