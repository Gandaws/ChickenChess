mutable struct Location
    row::Int64
    column::Char
    function Location(row::Int64, column::Char)
        if valid_location(row, column)
            return new(row, column)
        else
            println("Invalid location")
            return missing
        end
    end
end

Base.:(==)(loc1::Location, loc2::Location) = (loc1.row == loc2.row) && (loc1.column == loc2.column)

function valid_location(row::Int64, column::Char)
    if row < 1 || row > 8
        return false
    end

    column = uppercase(column)
    if column < 'A' || column > 'H'
        return false
    end

    return true
end

abstract type AbstractChessPiece end

@enum Player_colour Black White

# Pawn
mutable struct Egg <: AbstractChessPiece
    location::Union{Missing, Location}
    colour::Player_colour
    move_number::Int64
    taken::Bool
    Egg(row::Int64, column::Char, colour::Player_colour, move_number::Int64 = 0, taken::Bool = false) = new(Location(row, column), colour, move_number, taken)
end

# Castle
mutable struct Coop <: AbstractChessPiece
    location::Union{Missing, Location}
    colour::Player_colour
    taken::Bool
    Coop(row::Int64, column::Char, colour::Player_colour, taken::Bool = false) = new(Location(row, column), colour, taken)
end

# Knight
mutable struct Farmer <: AbstractChessPiece
    location::Union{Missing, Location}
    colour::Player_colour
    taken::Bool
    Farmer(row::Int64, column::Char, colour::Player_colour, taken::Bool = false) = new(Location(row, column), colour, taken)
end

# Bishop
mutable struct Chick <: AbstractChessPiece
    location::Union{Missing, Location}
    colour::Player_colour
    taken::Bool
    Chick(row::Int64, column::Char, colour::Player_colour, taken::Bool = false) = return new(Location(row, column), colour, taken)
end

# Queen
mutable struct Hen <: AbstractChessPiece
    location::Union{Missing, Location}
    colour::Player_colour
    taken::Bool
    Hen(row::Int64, column::Char, colour::Player_colour, taken::Bool = false) = new(Location(row, column), colour, taken)
end

# King
mutable struct Rooster <: AbstractChessPiece
    location::Union{Missing, Location}
    colour::Player_colour
    taken::Bool
    Rooster(row::Int64, column::Char, colour::Player_colour, taken::Bool = false) = new(Location(row, column), colour, taken)
end

