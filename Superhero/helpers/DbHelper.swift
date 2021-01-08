import Foundation
import SQLite

class DbHelper {
    var db: Connection? = nil
    
    var superheroTable: SuperheroTable!
    
    func connect(){
        do{
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            
            db = try Connection("\(path)/db.sqlite3")
            
            superheroTable = SuperheroTable(db: db)
        } catch let error {
            print("Connect Error: \(error)")
        }
    }
}
