enum GameState: String {
    case PLAYING = "Playing"
    case DRAW = "Its a draw!"
    case CROSS_WON = "Cross has won!"
    case ZERO_WON = "Zero has won!"
    
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

extension CellState {
    var isEmpty : Bool {
        if case .EMPTY = self {
            return true
        }
        return false
    }
}

enum PlayerMark: String {
    case X = "X"
    case O = "O"
    
    var description: String {
        return self.rawValue
    }
}
