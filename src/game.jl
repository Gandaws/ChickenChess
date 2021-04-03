mutable struct Game
    player1::Player
    player2::Player
    turn::Player_colour
    finished::Bool
    Game(player1::Player, player2::Player, turn::Player_colour = White::Player_colour, finished::Bool = false) = new(player1, player2, turn, finished)
end

print_piece(m::Missing) = print('〰')
print_piece(egg::Egg) = print('🐣')
print_piece(coop::Coop) = print('🏡')
print_piece(farmer::Farmer) = print('👴')
print_piece(chick::Chick) = print('🐥')
print_piece(hen::Hen) = print('🐔')
print_piece(rooster::Rooster) = print('🐓')

print_spacer() = print(' ')

function display_game(game::Game)
    println("Gameboard:")
    println("   A   B   C   D   E   F   G   H")

    for row = 1:8
        print("$row ")
        for column = 'A':'H'
            print_spacer()
            
            print_piece(find_piece(game, Location(row, column)))

            print_spacer()
        end
        println()
    end
end

function find_piece(game::Game, location::Location)
    for piece in vcat(game.player1.chess_pieces, game.player2.chess_pieces)
        if piece.taken == false
            if piece.location == location
                return piece
            end
        end
    end

    return missing
end