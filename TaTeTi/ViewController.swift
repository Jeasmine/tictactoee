import UIKit

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
    
    let rows = 3
    let columns = 3
    
    var boardGame = Array(repeating: Array(repeating: CellState.EMPTY, count: 3), count: 3)
    var currentPlayer : Player = Player.X
    
    override func viewDidLoad() {
        super.viewDidLoad()    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        var button : UIButton
        let cellState = currentPlayer == Player.X ? CellState.CROSS : CellState.ZERO
        var currentRow = 0
        var currentColumn = 0
        
        switch sender.tag {
        case 1:
            currentRow = 0
            currentColumn = 0
            boardGame[0][0] = cellState
            button = aButton
            break
        case 2:
            currentRow = 0
            currentColumn = 1
            boardGame[0][1] = cellState
            button = bButton
            break
        case 3:
            currentRow = 0
            currentColumn = 2
            boardGame[0][2] = cellState
            button = cButton
            break
        case 4:
            currentRow = 1
            currentColumn = 0
            boardGame[1][0] = cellState
            button = dButton
            break
        case 5:
            currentRow = 1
            currentColumn = 1
            boardGame[1][1] = cellState
            button = eButton
            break
        case 6:
            currentRow = 1
            currentColumn = 2
            boardGame[1][2] = cellState
            button = fButton
            break
        case 7:
            currentRow = 2
            currentColumn = 0
            boardGame[2][0] = cellState
            button = gButton
            break
        case 8:
            currentRow = 2
            currentColumn = 1
            boardGame[2][1] = cellState
            button = hButton
            break
        default:
            currentRow = 2
            currentColumn = 2
            boardGame[2][2] = cellState
            button = iButton
            break
        }
        
        button.setTitle(currentPlayer.description, for: .normal)
        button.isUserInteractionEnabled = false
        print("Has won: \(hasWon(theSeed: cellState, currentRow: currentRow, currentCol: currentColumn)) player: \(currentPlayer.description)")
        print("Is draw: \(isDraw())")
        
        swapPlayer()
    }
}

extension ViewController {
    
    func swapPlayer() {
        currentPlayer = currentPlayer == Player.X ? Player.O : Player.X
    }
    
    func hasWon(theSeed: CellState, currentRow: Int, currentCol: Int) -> Bool{
        return boardGame[currentRow][0] == theSeed &&
            boardGame[currentRow][1] == theSeed &&
            boardGame[currentRow][2] == theSeed ||
            boardGame[0][currentCol] == theSeed &&
            boardGame[1][currentCol] == theSeed &&
            boardGame[2][currentCol] == theSeed ||
            currentRow == currentCol &&
            boardGame[0][0] == theSeed &&
            boardGame[1][1] == theSeed &&
            boardGame[2][2] == theSeed ||
            currentRow + currentCol == 2  &&
            boardGame[0][2] == theSeed &&
            boardGame[1][1] == theSeed &&
            boardGame[2][0] == theSeed
    }
    
    func isDraw() -> Bool {
        var result = true
        for rIndex in 0..<rows {
            for cIndex in 0..<columns {
                let cell = boardGame[rIndex][cIndex] as CellState
                if(cell.isEmpty) {
                    result = false
                    break
                }
            }
        }
        return result
    }
}
