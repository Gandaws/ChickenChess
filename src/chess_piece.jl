abstract type AbstractChessPiece end

# Pawn
struct Egg <: AbstractChessPiece
    row::Int64
    column::Char
    move_number::Int64
    taken::Bool
    function Egg(row::Int64, column::Char, move_number::Int64 = 0, taken::Bool = false)  
        validate_location(row, column)
        return new(row, column, move_number, taken)
    end
end

# Castle
struct Coop <: AbstractChessPiece
    row::Int64
    column::Char
    taken::Bool
    function Coop(row::Int64, column::Char, taken::Bool = false) 
        validate_location(row, column)
        return new(row, column, taken)
    end
end

# Knight
struct Farmer <: AbstractChessPiece
    row::Int64
    column::Char
    taken::Bool
    function Farmer(row::Int64, column::Char, taken::Bool = false) 
        validate_location(row, column)
        return new(row, column, taken)
    end
end

# Bishop
struct Chick <: AbstractChessPiece
    row::Int64
    column::Char
    taken::Bool
    function Chick(row::Int64, column::Char, taken::Bool = false) 
        validate_location(row, column)
        return new(row, column, taken)
    end
end

# Queen
struct Hen <: AbstractChessPiece
    row::Int64
    column::Char
    taken::Bool
    function Hen(row::Int64, column::Char, taken::Bool = false) 
        validate_location(row, column)
        return new(row, column, taken)
    end
end

# King
struct Rooster <: AbstractChessPiece
    row::Int64
    column::Char
    taken::Bool
    function Rooster(row::Int64, column::Char, taken::Bool = false) 
        validate_location(row, column)
        return new(row, column, taken)
    end
end

function validate_location(row::Int64, column::Char)
    if row < 1 || row > 8
        error("Invalid row")
    end

    column = uppercase(column)
    if column < 'A' || column > 'H'
        error("Invalid column")
    end

    return row, column
end


