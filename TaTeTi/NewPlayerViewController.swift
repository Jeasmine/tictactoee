import UIKit
import CoreData

class NewPlayerViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    let dataManager = PlayerLocalDataManager()
    
    @IBAction func onSaveClick(_ sender: Any) {
        guard let firstName = nameField.text, !firstName.isEmpty else {
            MessageBuilder.showErrorMessage(titleMessage: "Field needed!", bodyMessage: "Name must not be empty")
            return
        }
        var age = 0
        if let ageString = ageField.text, !ageString.isEmpty {
            age = Int(ageString)!
        }
        do {
            let player = try dataManager.createPlayer(firstName: firstName, lastName: lastNameField.text, email: emailField.text, age: Int16(age))
            print(player)
            self.navigationController?.popViewController(animated: true)
        } catch {
            MessageBuilder.showErrorMessage(titleMessage: "Error", bodyMessage: "Could not create player")
        }
    }
}
