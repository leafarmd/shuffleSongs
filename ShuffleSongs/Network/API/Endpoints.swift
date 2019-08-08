import Foundation

enum APIRequest {
    case songs(id: String, limit: Int)
}

extension APIRequest {
    
    private var baseUrl: String {
        return "https://us-central1-tw-exercicio-mobile.cloudfunctions.net"
    }
    
    var url: String {
        switch self {
        case .songs:
            return "\(baseUrl)/lookup"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .songs:
            return .GET
        }
    }
    
    var params: [String: String] {
        switch self {
        case .songs(let id, let limit):
            return ["id": id, "limit": "\(limit)"]
        }
    }
}
