import Foundation

struct SearchResponse: Codable {
    var response: String? = nil
    var resultsFor: String? = nil
    var results: [Superhero]? = nil
}
