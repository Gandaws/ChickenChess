@enum Player_type Computer Person

"""
    Player(name, type, colour, level)

Creates a new Player object with fields name, type(computer / human), colour(White / Black) 
and pieces at starting locations
"""
struct Player
    level::Int64
    name::String
    type::Player_type
    colour::Player_colour
    chess_pieces::Array{AbstractChessPiece, 1}
    Player(name::String, type::Player_type, colour::Player_colour, level::Int64 = 1) = new(level, name, type, colour, set_up_pieces(colour))
end

"""
    set_up_pieces(colour)

Creates an array of pieces at starting locations (depends on the colour of the pieces).
"""
function set_up_pieces(colour::Player_colour)
    chess_pieces = Array{AbstractChessPiece, 1}(undef, 16)
    
    pawn_row = 2
    pieces_row = 1
    if colour == Black::Player_colour
        pawn_row = 7
        pieces_row = 8
    end

    chess_pieces[1] = Egg(pawn_row, 'A', colour)
    chess_pieces[2] = Egg(pawn_row, 'B', colour)
    chess_pieces[3] = Egg(pawn_row, 'C', colour)
    chess_pieces[4] = Egg(pawn_row, 'D', colour)
    chess_pieces[5] = Egg(pawn_row, 'E', colour)
    chess_pieces[6] = Egg(pawn_row, 'F', colour)
    chess_pieces[7] = Egg(pawn_row, 'G', colour)
    chess_pieces[8] = Egg(pawn_row, 'H', colour)
    chess_pieces[9] = Coop(pieces_row, 'A', colour)
    chess_pieces[10] = Farmer(pieces_row, 'B', colour)
    chess_pieces[11] = Chick(pieces_row, 'C', colour)
    chess_pieces[12] = Hen(pieces_row, 'D', colour)
    chess_pieces[13] = Rooster(pieces_row, 'E', colour)
    chess_pieces[14] = Chick(pieces_row, 'F', colour)
    chess_pieces[15] = Farmer(pieces_row, 'G', colour)
    chess_pieces[16] = Coop(pieces_row, 'H', colour)

    return chess_pieces
end

"""
    common_piece_checks(new_location, current_player, other_player)

Common move checks - if you are trying to move onto a square that already 
contains one of your pieces or where your opponents king is.
"""
function common_piece_checks(new_location::Location, current_player::Player, other_player::Player)
    if !ismissing(find_piece(current_player, new_location))
        return false
    end

    if typeof(find_piece(other_player, new_location)) == Rooster
        return false
    end

    return true
end

"""
    check_valid_move(piece, new_location, current_player, other_player)

Checks for if it is a valid move - this is overloaded for different piece types!
"""
function check_valid_move(piece::Egg, new_location::Location, current_player::Player, other_player::Player)
    if !common_piece_checks(new_location, current_player, other_player)
        return false
    end

    delta_row = new_location.row - piece.location.row
    delta_column = new_location.column - piece.location.column 

    if piece.colour == White::Player_colour
        if !((delta_row == 2 && piece.move_number == 0) || delta_row == 1)
            return false
        end
    else
        if !((delta_row == -2 && piece.move_number == 0) || delta_row == -1)
            return false
        end
    end

    if delta_column > 1 || delta_column < -1
        return false
    end

    if (delta_column == 1 || delta_column == -1) && ismissing(find_piece(other_player, new_location))
        return false
    end

    return true
end
