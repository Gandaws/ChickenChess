module ChickenChess

include("chess_piece.jl")
include("player.jl")
include("game.jl")

export play_chess

function play_chess()
    println("Enter your name:")
    name = readline()

    println("Do you wish to play against another person (y/n)?")
    response = readline()

    if response == "y"
        println("Enter opponent name:")
        opponent = readline()
    else
        error("Only human players supported atm")
    end

    player1 = Player(name, Person::Player_type, White::Player_colour)
    player2 = Player(opponent, Person::Player_type, Black::Player_colour)

    game = Game(player1, player2)
    
    display_game(game)
end

end # module
