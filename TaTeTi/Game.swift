import CoreData

@objc(Game)
class Game: NSManagedObject {
 
    var resultState: GameState {
        get {
            return EnumFactory.getGameState(stateInt: result)
        }
    }
}
