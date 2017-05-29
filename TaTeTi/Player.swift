import UIKit
import CoreData

@objc(Player)
class Player: NSManagedObject {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var email: String?
}
