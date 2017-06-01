import UIKit

class RankingViewCell: UITableViewCell {

    @IBOutlet weak var rankingPlayerName: UILabel!
    @IBOutlet weak var playerRanking: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
