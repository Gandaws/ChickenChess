using Test
using ChickenChess

include("chess_piece.jl")
include("player.jl")

@testset "parse_location" begin
    @test ismissing(ChickenChess.parse_location("hello world!"))
    @test ismissing(ChickenChess.parse_location("A3"))
    @test ismissing(ChickenChess.parse_location("9A"))
    @test ChickenChess.parse_location("3A") == ChickenChess.Location(3, 'A')
end
