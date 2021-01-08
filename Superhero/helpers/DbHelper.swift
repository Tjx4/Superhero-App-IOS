import Foundation
import SQLite

class DbHelper {
    var db: Connection? = nil
    
    func connect(){
        do{
            db = try Connection("path/to/db.sqlite3")
        } catch let error {
            print("Connect Error: \(error)")
        }
    }
}

