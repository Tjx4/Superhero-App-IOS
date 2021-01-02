import Foundation
import Moya

enum SuperheroService {
    case search(keyword: String)
    case apearance(id: String)
}

extension SuperheroService: TargetType {
  static var apikey = "191417135981966"
    
  public var baseURL: URL {
    return URL(string: "https://superheroapi.com/")!
  }

  public var path: String {
    switch self {
        case .search(let keyword): return "api/\(SuperheroService.apikey)/search/\(keyword)"
        case .apearance(let id): return "api/\(SuperheroService.apikey)/\(id)/appearance"
    }
  }

  var method: Moya.Method {
    switch self {
        case .search: return .get
        case .apearance: return .get
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
     switch self {
         case .search: return .requestPlain
         case .apearance: return .requestPlain
         //   case .apearance(let myId): return .requestParameters(parameters: ["id" : "myId", "name" : "My name"], encoding: JSONEncoding.default)
     }
  }

  var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  var validationType: ValidationType {
    return .successCodes
  }
    
}
