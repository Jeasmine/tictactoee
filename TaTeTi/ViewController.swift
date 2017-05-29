import UIKit
import CoreData

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
    var currentPlayer : PlayerMark = PlayerMark.X
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as! Player
//        newUser.firstName = "Vicenzo"
//        newUser.lastName = "Corleone"
//        
//        do {
//            try context.save()
//        } catch {
//        }
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                print(result)
            }
        } catch {
        
        }
        
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        var button : UIButton
        let cellState = currentPlayer == PlayerMark.X ? CellState.CROSS : CellState.ZERO
        var currentRow = 0
        var currentColumn = 0
        
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
        print("Has won: \(hasWon(theSeed: cellState, currentRow: currentRow, currentCol: currentColumn)) player: \(currentPlayer.description)")
        print("Is draw: \(isDraw())")
        
        swapPlayer()
    }
}

extension ViewController {
    
    func swapPlayer() {
        currentPlayer = currentPlayer == PlayerMark.X ? PlayerMark.O : PlayerMark.X
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
        return boardGame.filter { (boardArray:[CellState]) -> Bool in
            return boardArray.filter({ (cellState: CellState) -> Bool in
                return cellState.isEmpty
            }).count > 0
        }.isEmpty
    }
}
