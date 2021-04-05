mutable struct Game
    player1::Player
    player2::Player
    turn::Player_colour
    finished::Bool
    Game(player1::Player, player2::Player, turn::Player_colour = White::Player_colour, finished::Bool = false) = new(player1, player2, turn, finished)
end

function print_rgb(r, g, b, t)
    print("\e[1m\e[38;2;$r;$g;$b;249m", t)
end

print_piece(m::Missing) = print_rgb(200, 200, 200, '〰')

print_piece(egg::Egg) = egg.colour == White::Player_colour ? print_rgb(255, 255, 255, '🐣') : print_rgb(100, 100, 100, '🐣')
print_piece(coop::Coop) = coop.colour == White::Player_colour ? print_rgb(255, 255, 255, '🏡') : print_rgb(100, 100, 100, '🏡')
print_piece(farmer::Farmer) = farmer.colour == White::Player_colour ? print_rgb(255, 255, 255, '👴') : print_rgb(100, 100, 100, '👴')
print_piece(chick::Chick) = chick.colour == White::Player_colour ? print_rgb(255, 255, 255, '🐤') : print_rgb(100, 100, 100,'🐤')
print_piece(hen::Hen) = hen.colour == White::Player_colour ? print_rgb(255, 255, 255, '🐓') : print_rgb(100, 100, 100, '🐓')
print_piece(rooster::Rooster) = rooster.colour == White::Player_colour ? print_rgb(255, 255, 255, '🐔') : print_rgb(100, 100, 100, '🐔')

print_spacer() = print_rgb(200, 200, 200, ' ')

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
    for piece ∈ vcat(game.player1.chess_pieces, game.player2.chess_pieces)
        if piece.taken == false
            if piece.location == location
                return piece
            end
        end
    end

    return missing
end

function find_piece(player::Player, location::Location)
    for piece ∈ player.chess_pieces
        if piece.taken == false
            if piece.location == location
                return piece
            end
        end
    end

    return missing
end