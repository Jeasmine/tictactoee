enum GameState: String {
    case PLAYING = "PLAYING"
    case DRAW = "DRAW"
    case CROSS_WON = "CROSS_WON"
    case ZERO_WON = "ZERO_WON"
    
    var description: String {
        return self.rawValue
    }
}

enum CellState: String {
    case EMPTY = "EMPTY"
    case CROSS = "CROSS"
    case ZERO = "ZERO"
    
    var description: String {
        return self.rawValue
    }
}

enum Player: String {
    case X = "X"
    case O = "O"
    
    var description: String {
        return self.rawValue
    }
}


extension CellState {
    var isEmpty : Bool {
        if case .EMPTY = self {
            return true
        }
        return false
    }
}
