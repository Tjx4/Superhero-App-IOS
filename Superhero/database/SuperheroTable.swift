import Foundation
import SQLite

class SuperheroTable {
    var db: Connection? = nil
    
    let favouriteHeros = Table("favouriteHeros")
    
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let intelligence = Expression<String?>("intelligence")
    let strength = Expression<String?>("strength")
    let speed = Expression<String?>("speed")
    let fullName = Expression<String?>("fullName")
    let alterEgos = Expression<String?>("alterEgos")
    let placeOfBirth = Expression<String?>("placeOfBirth")
    let publisher = Expression<String?>("publisher")
    let rating = Expression<Double>("rating")
    let imageUrl = Expression<String>("imageUrl")
    
    init(db: Connection?) {
        self.db = db
        createTable()
    }
    
    func createTable(){
        do {
            try db?.run(favouriteHeros.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(intelligence)
                t.column(strength)
                t.column(speed)
                t.column(fullName)
                t.column(alterEgos)
                t.column(placeOfBirth)
                t.column(publisher)
                t.column(rating, defaultValue: 0.0)
                t.column(imageUrl)
            })
         
        } catch let error {
            print("Create Error: \(error)")
        }
        
    }
    
    func insert(superhero: FavSuperhero){
        do {
            let insert = favouriteHeros.insert(
                name <- superhero.name,
                intelligence <- superhero.intelligence,
                strength <- superhero.strength,
                speed <- superhero.speed,
                fullName <- superhero.fullName,
                alterEgos <- superhero.alterEgos,
                placeOfBirth <- superhero.placeOfBirth,
                publisher <- superhero.publisher,
                rating <- Double(superhero.rating),
                imageUrl <- superhero.imageUrl ?? "")
            try db?.run(insert)
            
        } catch let error {
            print("Insert Error: \(error)")
        }
    }
  
    func update(superhero: FavSuperhero) {
        do {
            let rowId:Int64  = Int64(superhero.id ?? "0") ?? 0
            let user = favouriteHeros.filter(id == rowId)

            try db?.run(user.update(
                name <- superhero.name,
                intelligence <- superhero.intelligence ,
                strength <- superhero.strength,
                speed <- superhero.speed,
                fullName <- superhero.fullName ,
                alterEgos <- superhero.alterEgos,
                placeOfBirth <- superhero.placeOfBirth ,
                publisher <- superhero.publisher,
                rating <- Double(superhero.rating) ,
                imageUrl <- superhero.imageUrl ?? ""))
            
        } catch let error {
            print("Update Error: \(error)")
        }
    }
    
    func getAll() -> [FavSuperhero] {
        var favSuperHeroes = [FavSuperhero]()
        do {
            //Todo fix
            for superheroTable in try db!.prepare(favouriteHeros) {
                var superhero = FavSuperhero()
                superhero.name = superheroTable[name]
                superhero.intelligence = superheroTable[intelligence]
                superhero.strength = superheroTable[strength]
                superhero.speed = superheroTable[speed]
                superhero.fullName = superheroTable[fullName]
                superhero.alterEgos = superheroTable[alterEgos]
                superhero.placeOfBirth = superheroTable[placeOfBirth]
                superhero.publisher = superheroTable[publisher]
                superhero.rating = Float(superheroTable[rating])
                superhero.imageUrl = superheroTable[imageUrl]
                
                favSuperHeroes.append(superhero)
            }
            
        } catch let error {
            print("GetAll Error: \(error)")
        }
        
        return favSuperHeroes
    }
    
    func getFavHero() -> FavSuperhero? {
        var favSuperHeroe: FavSuperhero?
        do {
            //Todo fix
            for superheroTable in try db!.prepare(favouriteHeros) {
                var superhero = FavSuperhero()
                superhero.name = superheroTable[name]
                superhero.intelligence = superheroTable[intelligence]
                superhero.strength = superheroTable[strength]
                superhero.speed = superheroTable[speed]
                superhero.fullName = superheroTable[fullName]
                superhero.alterEgos = superheroTable[alterEgos]
                superhero.placeOfBirth = superheroTable[placeOfBirth]
                superhero.publisher = superheroTable[publisher]
                superhero.rating = Float(superheroTable[rating])
                superhero.imageUrl = superheroTable[imageUrl]
                
            }
            
        } catch let error {
            print("getFavHero Error: \(error)")
        }
        
        return favSuperHeroe
    }
    
    func delete(rowId: Int64){
        do {
            let superhero = favouriteHeros.filter(id == rowId)
            try db?.run(superhero.delete())
            
        } catch let error {
            print("Delete Error: \(error)")
        }

    }    
    
}
