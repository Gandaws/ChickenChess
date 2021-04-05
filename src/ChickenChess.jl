module ChickenChess

include("chess_piece.jl")
include("player.jl")
include("game.jl")

import REPL
using REPL.TerminalMenus

export play_chess

function play_chess()
    println("Enter your name:")
    name = readline()

    options = ["white", "black"]
    menu = RadioMenu(options, pagesize = 2)
    choice = request("Choose your colour:", menu)

    player_colour_selected = Black::Player_colour
    if choice == -1
        error("menu cancelled!")
    elseif options[choice] == "white"
        player_colour_selected = White::Player_colour
    end

    options = ["human", "computer"]
    menu = RadioMenu(options, pagesize = 2)
    choice = request("Choose your opponent type:", menu)

    if choice == -1
        error("menu cancelled!")
    elseif options[choice] == "computer"
        error("Only human players supported atm")
    end
    
    println("Enter opponent name:")
    opponent = readline()

    player1 = Player(name, Person::Player_type, player_colour_selected)
    player2 = Player(opponent, Person::Player_type, player_colour_selected == White::Player_colour ? Black::Player_colour : White::Player_colour)
    game = Game(player1, player2)

    display_game(game)
    while game.finished == false
        next_turn(game)

        display_game(game)
    end
end

function next_turn(game::Game)
    current_player = game.player1.colour == game.turn ? game.player1 : game.player2
    println("It is $(current_player.name)'s turn they are $(current_player.colour):")

    # Get valid move
    piece, new_location = get_move(game, current_player)

    # Do move
    piece.location = new_location
    if typeof(piece) == Egg
        piece.move_number += 1
    end

    # Check if game finished

    game.turn = current_player.colour == Black::Player_colour ? White::Player_colour : Black::Player_colour
end

function get_move(game::Game, current_player::Player)
    piece = missing
    while ismissing(piece)
        println("What piece would you like to move (enter valid location as row/column i.e. 2A):")
        location = parse_location(readline())
    
        if !ismissing(location)
            piece = find_piece(game, location)
            if ismissing(piece) || (piece.taken == true) || (piece.colour !== current_player.colour)
                piece = missing
            end
        end
        if ismissing(piece)
            println("Invalid response")
        end
    end

    new_location = missing
    # Check valid move!
    valid_move = false
    while !valid_move
        while ismissing(new_location)
            println("Where would you like to move (enter valid location as row/column i.e. 2A):")
            new_location = parse_location(readline())
            if ismissing(new_location)
                println("Invalid response")
            end
        end
        valid_move = check_valid_move(piece, new_location)
        if !valid_move
            new_location = missing
            println("Invalid move")
        end
    end

    return piece, new_location
end

function check_valid_move(piece::Egg, new_location::Location)
    delta_row = new_location.row - piece.location.row
    delta_column = new_location.column - piece.location.column 

    if piece.colour == White::Player_colour
        if (delta_row == -2 && piece.move_number == 0) || delta_row == -1
            return false
        end
    else
        if (delta_row == 2 && piece.move_number == 0) || delta_row == 1
            return false
        end
    end

    return true
end

function parse_location(response::String)
    if length(response) !== 2
        return missing
    end

    row = -1
    try
        row = parse(Integer, response[1])
    catch
        return missing
    end

    column = response[2]

    return Location(row, column)
end

end # module
