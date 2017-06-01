import UIKit
import DZNEmptyDataSet

class PlayersViewController: UITableViewController {
    
    let dataManager = PlayerLocalDataManager()
    let cellIdentifier = "player_cell"
    let numberOfPlayers = 2
    var players: [Player] = []
    var selectedPlayers: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            selectedPlayers = []
            players = try dataManager.retrievePlayerList()
        } catch {
            fatalError(ERROR_RETRIEVING_PLAYERS)
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerViewCell else {
            fatalError("The dequeued cell is not an instance of PlayerViewCell")
        }
        cell.playerName.text = players[indexPath.row].fullName
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sr = tableView.indexPathsForSelectedRows, sr.count <= numberOfPlayers {
            if let cell = tableView.cellForRow(at: indexPath), cell.isSelected {
                cell.accessoryType = .checkmark
                selectedPlayers.append(players[indexPath.row])
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            selectedPlayers.remove(object: players[indexPath.row])
        }
    }
}

extension PlayersViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "game_segue" ) {
            let secondViewController = segue.destination as! ViewController
            secondViewController.selectedPlayers = selectedPlayers
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "game_segue" ) {
            if (selectedPlayers.count == 2) {
                return true
            }
            
            MessageBuilder.showErrorMessage(titleMessage: PLAYERS_NEEDED, bodyMessage: SELECT_PLAYERS)
            return false
        }
        return true
    }
}

extension PlayersViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "emptyData")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.purple ]
        return NSAttributedString(string: NO_PLAYERS, attributes: myAttribute)
    }
}
