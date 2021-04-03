struct Game
    player1::Player
    player2::Player
end

print_piece(n::Nothing) = print("〰")
print_piece(egg::Egg) = print('🐣')
print_piece(coop::Coop) = print('🏡')
print_piece(farmer::Farmer) = print('👴')
print_piece(chick::Chick) = print('🐥')
print_piece(hen::Hen) = print('🐔')
print_piece(rooster::Rooster) = print('🐓')

print_spacer() = print(' ')

function display_game(game::Game)
    println("Gameboard:")

    for row = 1:8
        for column = 'A':'H'
            print_spacer()
            
            print_piece(find_piece(game, row, column))

            print_spacer()
        end
        println()
    end
end

function find_piece(game::Game, row::Int64, column::Char)
    validate_location(row, column)

    for piece in vcat(game.player1.chess_pieces, game.player2.chess_pieces)
        if piece.taken == false
            if piece.row == row && piece.column == column
                return piece
            end
        end
    end

    return nothing
end