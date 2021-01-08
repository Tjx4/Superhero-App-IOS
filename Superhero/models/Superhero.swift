struct Superhero: Codable {
    var id: String? = nil
    var name: String? = nil
    var powerstats: PowerStats? = nil
    var biography: Biography? = nil
    var appearance: Appearance? = nil
    var work: Work? = nil
    var connections: Connections? = nil
    var image: Image? = nil
    var rating: Float = 0
    var isFav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case powerstats = "powerstats"
        case biography = "biography"
        case appearance = "appearance"
        case work = "work"
        case connections = "connections"
        case image = "image"
   }
}
