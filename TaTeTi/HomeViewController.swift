import Foundation

import UIKit
import SwiftMessages
import DZNEmptyDataSet

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureTheme(.warning)
            view.configureDropShadow()
            let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
            view.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)

            return view
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension HomeViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
 
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "emptyData")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myString = "No data"
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.blue ]
        return NSAttributedString(string: myString, attributes: myAttribute)
    }
}
