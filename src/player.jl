@enum Player_type Computer Person
@enum Player_colour Black White

struct Player
    level::Int64
    name::String
    type::Player_type
    colour::Player_colour
    chess_pieces::Array{AbstractChessPiece, 1}
    Player(name::String, type::Player_type, colour::Player_colour, level::Int64 = 1) = new(level, name, type, colour, set_up_pieces(colour))
end

function set_up_pieces(colour::Player_colour)
    chess_pieces = Array{AbstractChessPiece, 1}(undef, 16)
    
    pawn_row = 2
    pieces_row = 1
    if colour == Black::Player_colour
        pawn_row = 7
        pieces_row = 8
    end

    chess_pieces[1] = Egg(pawn_row, 'A')
    chess_pieces[2] = Egg(pawn_row, 'B')
    chess_pieces[3] = Egg(pawn_row, 'C')
    chess_pieces[4] = Egg(pawn_row, 'D')
    chess_pieces[5] = Egg(pawn_row, 'E')
    chess_pieces[6] = Egg(pawn_row, 'F')
    chess_pieces[7] = Egg(pawn_row, 'G')
    chess_pieces[8] = Egg(pawn_row, 'H')
    chess_pieces[9] = Coop(pieces_row, 'A')
    chess_pieces[10] = Farmer(pieces_row, 'B')
    chess_pieces[11] = Chick(pieces_row, 'C')
    if colour == Black::Player_colour
        chess_pieces[12] = Hen(pieces_row, 'D')
        chess_pieces[13] = Rooster(pieces_row, 'E')
    else
        chess_pieces[12] = Rooster(pieces_row, 'D')
        chess_pieces[13] = Hen(pieces_row, 'E')
    end
    chess_pieces[14] = Chick(pieces_row, 'F')
    chess_pieces[15] = Farmer(pieces_row, 'G')
    chess_pieces[16] = Coop(pieces_row, 'H')

    return chess_pieces
end

#=
function move_chess_piece(player::Player, opponent::Player, piece_to_move::Int64, new_row::Int64, new_column::Char)
    new_row, new_column = validate_location(new_row, new_column)
    if player.chess_pieces[piece_to_move].taken == true
        error("Can't move a taken piece")
    end

    if check_valid_move(piece, new_row, new_column)
        return chess_piece(piece.type, new_row, new_column, piece.move_number + 1)
    end

    return piece
end

function check_valid_move(piece::egg, new_row::Int64, new_column::Char)
    if piece.move_number == 0 && new_row - piece.row > 2
        return false
    elseif piece.move_number > 0 && new_row - piece.row > 1
        return false
    elseif piece.column !== new_column
        return false
    end
        
    return true
end
=#