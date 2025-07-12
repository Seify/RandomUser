import Foundation

// Some fields are omitted
// See full model at https://randomuser.me/documentation

struct RandomUsers: Decodable {
    let results: [RandomUser]
}

struct RandomUser: Decodable {
    let gender: String
    let name: RandomUserName
    let location: RandomUserLocation
    let email: String
    let phone: String
    let picture: RandomUserPicture
}

struct RandomUserName: Decodable {
    let title: String
    let first: String
    let last: String
}

struct RandomUserLocation: Decodable {
    let street: RandomUserLocationStreet
    let city: String
    let state: String
}

struct RandomUserLocationStreet: Decodable {
    let number: Int
    let name: String
}

struct RandomUserRegistered: Decodable {
    let date: String
}

struct RandomUserPicture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
