import UIKit
import CoreData
import SwiftMessages

class ViewController: UIViewController {
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var hButton: UIButton!
    @IBOutlet weak var iButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    /*
     * Player one is always X
     */
    var playerOne: Player?
    var playerTwo: Player?
    var selectedPlayers: [Player] = []
    var currentGameState = GameState.PLAYING
    var currentPlayer = PlayerMark.X
    var boardGame = Array(repeating: Array(repeating: CellState.EMPTY, count: 3), count: 3)
    var dataManager = PlayerLocalDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlayers()
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        let cellState = currentPlayer == PlayerMark.X ? CellState.CROSS : CellState.ZERO
        var button: UIButton
        var currentRow: Int
        var currentColumn: Int
        
        switch sender.tag {
        case 1:
            currentRow = 0
            currentColumn = 0
            button = aButton
            break
        case 2:
            currentRow = 0
            currentColumn = 1
            button = bButton
            break
        case 3:
            currentRow = 0
            currentColumn = 2
            button = cButton
            break
        case 4:
            currentRow = 1
            currentColumn = 0
            button = dButton
            break
        case 5:
            currentRow = 1
            currentColumn = 1
            button = eButton
            break
        case 6:
            currentRow = 1
            currentColumn = 2
            button = fButton
            break
        case 7:
            currentRow = 2
            currentColumn = 0
            button = gButton
            break
        case 8:
            currentRow = 2
            currentColumn = 1
            button = hButton
            break
        default:
            currentRow = 2
            currentColumn = 2
            button = iButton
            break
        }
        
        boardGame[currentRow][currentColumn] = cellState
        button.setTitle(currentPlayer.description, for: .normal)
        button.isUserInteractionEnabled = false
        
        let gameEnded = hasGameEnded(currentCellState: cellState, currentRow: currentRow, currentColumn: currentColumn)
        if (gameEnded) {
            endGameLogic()
        } else {
            swapPlayer()
        }
    }
}

extension ViewController {
    
    func initPlayers() {
        if (selectedPlayers.count == 2) {
            playerOne = selectedPlayers[0]
            playerTwo = selectedPlayers[1]
            let playersMarkers = playerOne!.fullName + " is X\n" + playerTwo!.fullName + "is O"
            showInitialMessage(message: playersMarkers)
        }
    }
    
    func resetButtons() {
        for button in buttons {
            button.setTitle(" ", for: .normal)
            button.isUserInteractionEnabled = true
        }
    }
    
    func swapPlayer() {
        currentPlayer = currentPlayer == PlayerMark.X ? PlayerMark.O : PlayerMark.X
    }
    
    func endGameLogic() {
        boardGame = Array(repeating: Array(repeating: CellState.EMPTY, count: 3), count: 3)
        resetButtons()
        showGameEndedMessage()
        if (playerOne != nil && playerTwo != nil) {
            do {
                let game = try dataManager.createGame(playerX: playerOne!, playerO: playerTwo!, gameState: currentGameState)
                print(game)
                let players = try dataManager.retrieveRankingPlayerList()
                print (players)
            } catch {
                print("Could not save game")
            }
        }
    }
    
    func showGameEndedMessage() {
        MessageBuilder.showWarningMessage(titleMessage: "Game is over", bodyMessage: self.currentGameState.description)
    }
    
    func showInitialMessage(message : String) {
        MessageBuilder.showWarningMessage(titleMessage: "GO!", bodyMessage: message)
    }
    
    func hasGameEnded(currentCellState cellState: CellState, currentRow row: Int, currentColumn column: Int) -> Bool {
        if (hasWon(cellState, row, column)) {
            currentGameState = currentPlayer == PlayerMark.X ? GameState.CROSS_WON : GameState.ZERO_WON
        } else if (isDraw()) {
            currentGameState = GameState.DRAW
        } else {
            return false
        }
        return true
    }
    
    func hasWon(_ cellState: CellState, _ row: Int, _ column: Int) -> Bool {
        return boardGame[row][0] == cellState &&
            boardGame[row][1] == cellState &&
            boardGame[row][2] == cellState ||
            boardGame[0][column] == cellState &&
            boardGame[1][column] == cellState &&
            boardGame[2][column] == cellState ||
            row == column &&
            boardGame[0][0] == cellState &&
            boardGame[1][1] == cellState &&
            boardGame[2][2] == cellState ||
            row + column == 2  &&
            boardGame[0][2] == cellState &&
            boardGame[1][1] == cellState &&
            boardGame[2][0] == cellState
    }
    
    func isDraw() -> Bool {
        return boardGame.filter { (boardArray:[CellState]) -> Bool in
            return boardArray.filter({ (cellState: CellState) -> Bool in
                return cellState.isEmpty
            }).count > 0
            }.isEmpty
    }
}
