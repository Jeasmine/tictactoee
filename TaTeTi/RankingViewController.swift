import UIKit
import DZNEmptyDataSet

class RankingViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let dataManager = PlayerLocalDataManager()
    var topPlayers: [Player] = []
    let rankingCellIdentifier = "ranking_cell"
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            topPlayers = try dataManager.retrieveRankingPlayerList()
            print(topPlayers)
        } catch {
            print(ERROR_RETRIEVING_PLAYERS)
        }
        self.tableView.reloadData()
    }
}

extension RankingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rankingCellIdentifier, for:indexPath) as? RankingViewCell else {
            fatalError("The dequeued cell is not an instance of RankingViewCell")
        }
        cell.rankingPlayerName.text = topPlayers[indexPath.row].fullName
        cell.playerRanking.text = String(topPlayers[indexPath.row].ranking)
        return cell
    }
}

extension RankingViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
 
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "emptyData")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.blue ]
        return NSAttributedString(string: NO_PLAYERS, attributes: myAttribute)
    }
}
