enum Endpoints {
    static let baseUrl = "https://api.randomuser.me/"

    case users(Int)

    var path: String {
        switch self {
            case .users(let limit):
                Endpoints.baseUrl + "?results=\(limit)"
        }
    }
}
