@testset "Location" begin
    @test ChickenChess.valid_location(1, 'A') == true
    @test ChickenChess.valid_location(-1, 'A') == false
    @test ChickenChess.valid_location(9, 'A') == false
    @test ChickenChess.valid_location(1, 'j') == false
    @test ChickenChess.valid_location(1, 'K') == false

    @test ismissing(ChickenChess.Location(-1, 'A'))
    @test ismissing(ChickenChess.Location(1, 'J'))
    @test ChickenChess.Location(1, 'a').row == 1
    @test ChickenChess.Location(1, 'a').column == 'A'
    @test ChickenChess.Location(1, 'A') == ChickenChess.Location(1, 'a')

    @test ismissing(ChickenChess.Location("hello world!"))
    @test ismissing(ChickenChess.Location("A3"))
    @test ismissing(ChickenChess.Location("9A"))
    @test ChickenChess.Location("3A") == ChickenChess.Location(3, 'A')
end