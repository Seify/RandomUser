import Foundation

struct RandomUsers: Decodable {
    let results: [RandomUser]
}

struct RandomUser: Decodable {
    let email: String
}
