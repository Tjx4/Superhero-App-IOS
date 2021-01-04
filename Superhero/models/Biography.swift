struct Biography: Codable {
    var fullName: String? = nil
    var alterEgos: String? = nil
    var aliases: [String]? = nil
    var placeOfBirth: String? = nil
    var firstAppearance: String? = nil
    var publisher: String? = nil
    var alignment: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
        case alterEgos = "alter-egos"
        case placeOfBirth = "place-of-birth"
        case publisher = "publisher"
        case alignment = "alignment"
   }
}
