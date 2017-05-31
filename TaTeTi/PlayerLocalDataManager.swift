import CoreData
import UIKit

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotCreateObject
    case objectNotFound
}

class PlayerLocalDataManager {
    
    func player(firstName: String, lastName: String) throws -> Player {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        if let newPlayer =  NSEntityDescription.entity(forEntityName: "Player", in: context) {
            let player = Player(entity: newPlayer, insertInto: context)
            player.firstName = firstName
            player.lastName = lastName
            return player
        }
        throw PersistenceError.couldNotCreateObject
    }
    
    func createPlayer(firstName: String, lastName: String) throws -> Player {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        if let newPlayer = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as? Player {
            newPlayer.firstName = firstName
            newPlayer.lastName = lastName
            try context.save()
            return newPlayer
        }
        throw PersistenceError.couldNotCreateObject
    }
    
    func retrievePlayerList() throws -> [Player] {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.returnsObjectsAsFaults = false
        let caseInsensitiveSelector = #selector(NSString.caseInsensitiveCompare(_:))
        let sortDescriptorFirstName = NSSortDescriptor(key: "firstName", ascending: true, selector: caseInsensitiveSelector)
        let sortDescriptorLastName = NSSortDescriptor(key: "lastName", ascending: true, selector: caseInsensitiveSelector)
        request.sortDescriptors = [sortDescriptorFirstName, sortDescriptorLastName]
        
        return try context.fetch(request) as! [Player]
    }
}
