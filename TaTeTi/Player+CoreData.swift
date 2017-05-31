import CoreData

extension Player {
    
    @NSManaged var firstName: String
    @NSManaged var lastName: String?
    @NSManaged var email: String?
    @NSManaged var age: Int16
    @NSManaged var ranking: Int16
}
