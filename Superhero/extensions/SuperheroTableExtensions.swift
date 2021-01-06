import Foundation

extension SuperheroTable {
    
    func toSuperhero() -> Superhero{
        var superhero = Superhero()
        superhero.id = self.id
        superhero.name = self.name
        superhero.powerstats = PowerStats()
        superhero.powerstats?.intelligence = self.intelligence
        superhero.powerstats?.strength = self.strength
        superhero.powerstats?.speed = self.speed
        superhero.biography = Biography()
        superhero.biography?.fullName = self.fullName
        superhero.biography?.alterEgos = self.alterEgos
        superhero.biography?.placeOfBirth = self.placeOfBirth
        superhero.biography?.publisher = self.publisher
        superhero.rating = self.rating
        superhero.image = Image()
        superhero.image?.url = self.imageUrl
        
        return superhero
    }
}
