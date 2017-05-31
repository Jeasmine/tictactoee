import CoreData

@objc(Player)
class Player: NSManagedObject {
    
    var fullName: String {
        get {
            var name = firstName
            if let lastName = lastName {
                name += " \(lastName)"
            }
            return name
        }
    }
}
