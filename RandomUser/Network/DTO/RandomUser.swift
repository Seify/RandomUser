import Foundation

// Some fields are omitted
// See full model at https://randomuser.me/documentation

struct RandomUsers: Decodable, Equatable {
    let results: [RandomUser]
}

struct RandomUser: Decodable, Equatable {
    let login: RandomUserLogin
    let gender: String
    let name: RandomUserName
    let location: RandomUserLocation
    let email: String
    let phone: String
    let picture: RandomUserPicture
    let registered: RandomUserRegistered
}

struct RandomUserName: Decodable, Equatable {
    let title: String
    let first: String
    let last: String
}

struct RandomUserLocation: Decodable, Equatable {
    let street: RandomUserLocationStreet
    let city: String
    let state: String
}

struct RandomUserLocationStreet: Decodable, Equatable {
    let number: Int
    let name: String
}

struct RandomUserRegistered: Decodable, Equatable {
    let date: String
}

struct RandomUserPicture: Decodable, Equatable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct RandomUserLogin: Decodable, Equatable {
    let uuid: String
}
