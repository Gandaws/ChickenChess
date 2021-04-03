module ChickenChess

include("chess_piece.jl")
include("player.jl")
include("game.jl")

export play_chess

@enum yn Yes No

function play_chess()
    println("Enter your name:")
    name = readline()

    response = missing
    while ismissing(response)
        println("Do you wish to play against another person (y/n)?")
        response = parse_yn(readline())
        if ismissing(response)
            println("Invalid response")
        end
    end

    opponent = missing
    if response == Yes::yn
        println("Enter opponent name:")
        opponent = readline()
    else
        error("Only human players supported atm")
    end
    
    player1 = Player(name, Person::Player_type, White::Player_colour)
    player2 = Player(opponent, Person::Player_type, Black::Player_colour)
    game = Game(player1, player2)

    display_game(game)
    while game.finished == false
        next_turn(game)

        display_game(game)
    end
end

function next_turn(game::Game)
    current_player = game.player1.colour == game.turn ? game.player1 : game.player2
    println("It is $(current_player.name)'s turn:")

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
        if (delta_row == 2 && piece.move_number == 0) || delta_row == 1
            return false
        end
    else
        if (delta_row == -2 && piece.move_number == 0) || delta_row == -1
            return false
        end
    end

    return true
end

function parse_yn(response::String)
    # Case insensitive
    response = lowercase(response)

    if length(response) !== 1
        return missing
    end

    if response[1] == 'y'
        return Yes::yn
    elseif response[1] == 'n'
        return No::yn
    end

    return missing
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
