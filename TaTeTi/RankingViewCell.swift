import UIKit

class RankingViewCell: UITableViewCell {

    @IBOutlet weak var rankingPlayerName: UILabel!
    @IBOutlet weak var playerRanking: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
