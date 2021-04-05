"""
    Location(row, column)

Location structure with fields row / column, only valid chess locations are created else returns missing.
"""
mutable struct Location
    row::Int64
    column::Char
    function Location(row::Int64, column::Char)
        column = uppercase(column)
        if valid_location(row, column)
            return new(row, column)
        else
            println("Invalid location")
            return missing
        end
    end
end

"""
    Location(string)

Creates a chess location from a string - returns missing if invalid / can't parse.
"""
function Location(response::String)
    if length(response) !== 2
        println("Invalid location")
        return missing
    end

    row = -1
    try
        row = parse(Integer, response[1])
    catch
        println("Invalid location")
        return missing
    end

    column = response[2]

    return Location(row, column)
end

Base.:(==)(loc1::Location, loc2::Location) = (loc1.row == loc2.row) && (loc1.column == loc2.column)

"""
    valid_location(row, column)

Checks if the row / column is a valid chess location (returns true/false).
"""
function valid_location(row::Int64, column::Char)
    if row < 1 || row > 8
        return false
    end

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
    move_number::Int64
    taken::Bool
    Rooster(row::Int64, column::Char, colour::Player_colour, move_number::Int64 = 0, taken::Bool = false) = new(Location(row, column), colour, move_number, taken)
end

