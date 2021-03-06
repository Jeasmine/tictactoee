import CoreData
import UIKit

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotCreateObject
    case objectNotFound
}

class PlayerLocalDataManager {
    
    func createGame(playerX: Player, playerO: Player, gameState: GameState) throws -> Game {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        if let newGame = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context) as? Game {
            newGame.playerX = playerX
            newGame.playerO = playerO
            newGame.result = gameState.result
            
            playerX.setValue(playerX.ranking + (gameState == GameState.CROSS_WON ? 1 : gameState == GameState.ZERO_WON ? -1 : 0), forKey: "ranking")
            playerO.setValue(playerO.ranking + (gameState == GameState.ZERO_WON ? 1 : gameState == GameState.CROSS_WON ? -1 : 0), forKey: "ranking")
            
            try context.save()
            return newGame
        }
        throw PersistenceError.couldNotCreateObject
    }
    
    func retrieveGameList() throws -> [Game] {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        request.returnsObjectsAsFaults = false
        
        return try context.fetch(request) as! [Game]
    }
    
    func updatePlayer(player: Player) throws {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        try context.save()
        throw PersistenceError.couldNotCreateObject
    }
    
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
    
    func createPlayer(firstName: String, lastName: String?, email: String?, age: Int16) throws -> Player {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        if let newPlayer = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as? Player {
            newPlayer.firstName = firstName
            newPlayer.lastName = lastName
            newPlayer.email = email
            newPlayer.age = age
            try context.save()
            return newPlayer
        }
        throw PersistenceError.couldNotCreateObject
    }
    
    func retrievePlayerList() throws -> [Player] {
        let playerFetch = try makePlayerContextFetch()
        let caseInsensitiveSelector = #selector(NSString.caseInsensitiveCompare(_:))
        let sortDescriptorFirstName = NSSortDescriptor(key: "firstName", ascending: true, selector: caseInsensitiveSelector)
        let sortDescriptorLastName = NSSortDescriptor(key: "lastName", ascending: true, selector: caseInsensitiveSelector)
        playerFetch.request.sortDescriptors = [sortDescriptorFirstName, sortDescriptorLastName]
        
        return try playerFetch.context.fetch(playerFetch.request) as! [Player]
    }
    
    func retrieveRankingPlayerList() throws -> [Player] {
        let playerFetch = try makePlayerContextFetch()
        playerFetch.request.sortDescriptors = [NSSortDescriptor(key: "ranking", ascending: false)]
        
        return try playerFetch.context.fetch(playerFetch.request) as! [Player]
    }
    
    private func makePlayerContextFetch() throws -> (context: NSManagedObjectContext, request: NSFetchRequest<NSFetchRequestResult>) {
        guard let context = CoreDataPersistent.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.returnsObjectsAsFaults = false
        return (context, request)
    }
}
