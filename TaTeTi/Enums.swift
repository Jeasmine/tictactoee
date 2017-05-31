class EnumFactory {
    
    static func getGameState(stateInt: Int16) -> GameState {
        switch stateInt {
        case 1:
            return GameState.CROSS_WON
        case 2:
            return GameState.ZERO_WON
        default:
            return GameState.DRAW
        }
    }
}

enum GameState: String {
    case PLAYING = "Playing"
    case DRAW = "Its a draw!"
    case CROSS_WON = "Cross has won!"
    case ZERO_WON = "Zero has won!"
    
    var description: String {
        return self.rawValue
    }
    
    var result: Int16 {
        switch self {
        case .CROSS_WON:
            return 1
        case .ZERO_WON:
            return 2
        default:
            return 0
        }
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
