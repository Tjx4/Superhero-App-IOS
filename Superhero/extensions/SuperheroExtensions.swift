import Foundation

extension FavSuperhero {
    
    func toSuperhero() -> Superhero {
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

extension Superhero {
    
    func toFavSuperhero() -> FavSuperhero {
        var favSuperhero = FavSuperhero()
        favSuperhero.id = self.id
        favSuperhero.name = self.name
        favSuperhero.intelligence = self.powerstats?.intelligence
        favSuperhero.strength = self.powerstats?.strength
        favSuperhero.speed = self.powerstats?.speed
        favSuperhero.fullName = self.biography?.fullName
        favSuperhero.alterEgos = self.biography?.alterEgos
        favSuperhero.placeOfBirth = self.biography?.placeOfBirth
        favSuperhero.publisher = self.biography?.publisher
        favSuperhero.rating = self.rating

        favSuperhero.imageUrl = self.image?.url
        
        return favSuperhero
    }
}
