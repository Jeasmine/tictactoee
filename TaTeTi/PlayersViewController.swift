import UIKit
import DZNEmptyDataSet

class PlayersViewController: UITableViewController {
    
    let dataManager = PlayerLocalDataManager()
    var players: [Player] = []
    let cellIdentifier = "player_cell"
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            players = try dataManager.retrievePlayerList()
            print(players)
        } catch {
            print("Error retrieving players")
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
        return cell
    }
}

extension PlayersViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "emptyData")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myString = "No data"
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.purple ]
        return NSAttributedString(string: myString, attributes: myAttribute)
    }
}
