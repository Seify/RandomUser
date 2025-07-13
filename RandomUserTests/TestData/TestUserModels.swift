import XCTest
@testable import RandomUser

let testUserModelSherlockHolmes = RandomUserModel(
    title: "Mr",
    firstName: "Sherlock",
    lastName: "Holmes",
    gender: "male",
    streetNumber: 221,
    streetName: "Baker St",
    city: "London",
    state: "UK",
    email: "Sherlock.Holmes@yard.uk",
    phone: "123-45-67",
    registered: "1961-02-09T03:09:03.229Z",
    largePicture: "https://randomuser.me/api/portraits/men/14.jpg",
    mediumPicture: "https://randomuser.me/api/portraits/med/men/14.jpg",
    thumbnail: "https://randomuser.me/api/portraits/thumb/men/14.jpg",
    uuid: "11111",
    isDeleted: false
)

let testUserModelEmmaWatson = RandomUserModel(
    title: "Missis",
    firstName: "Emma",
    lastName: "Watson",
    gender: "female",
    streetNumber: 221,
    streetName: "Baker St",
    city: "London",
    state: "UK",
    email: "emma@watson.uk",
    phone: "123-45-67",
    registered: "1961-02-09T03:09:03.229Z",
    largePicture: "https://randomuser.me/api/portraits/men/14.jpg",
    mediumPicture: "https://randomuser.me/api/portraits/med/men/14.jpg",
    thumbnail: "https://randomuser.me/api/portraits/thumb/men/14.jpg",
    uuid: "22222",
    isDeleted: false
)

let testUserModelGregoryHouse = RandomUserModel(
    title: "Dr",
    firstName: "Gregory",
    lastName: "House",
    gender: "male",
    streetNumber: 221,
    streetName: "Baker St",
    city: "London",
    state: "UK",
    email: "dr.house@holmes.lies",
    phone: "123-45-67",
    registered: "1961-02-09T03:09:03.229Z",
    largePicture: "https://randomuser.me/api/portraits/men/14.jpg",
    mediumPicture: "https://randomuser.me/api/portraits/med/men/14.jpg",
    thumbnail: "https://randomuser.me/api/portraits/thumb/men/14.jpg",
    uuid: "33333",
    isDeleted: false
)

let testUserModelKarlWatson = RandomUserModel(
    title: "Mr",
    firstName: "Karl",
    lastName: "Watson",
    gender: "male",
    streetNumber: 221,
    streetName: "Baker St",
    city: "London",
    state: "UK",
    email: "KarlWatson@edu.com",
    phone: "123-45-67",
    registered: "1961-02-09T03:09:03.229Z",
    largePicture: "https://randomuser.me/api/portraits/men/14.jpg",
    mediumPicture: "https://randomuser.me/api/portraits/med/men/14.jpg",
    thumbnail: "https://randomuser.me/api/portraits/thumb/men/14.jpg",
    uuid: "44444",
    isDeleted: false
)

let testUserModelEmilWatson = RandomUserModel(
    title: "Mr",
    firstName: "Emil",
    lastName: "Watson",
    gender: "male",
    streetNumber: 221,
    streetName: "Baker St",
    city: "London",
    state: "UK",
    email: "EmilWatson@edu.com",
    phone: "123-45-67",
    registered: "1961-02-09T03:09:03.229Z",
    largePicture: "https://randomuser.me/api/portraits/men/14.jpg",
    mediumPicture: "https://randomuser.me/api/portraits/med/men/14.jpg",
    thumbnail: "https://randomuser.me/api/portraits/thumb/men/14.jpg",
    uuid: "55555",
    isDeleted: false
)

let testUserModels = [
    testUserModelEmilWatson,
    testUserModelEmmaWatson,
    testUserModelKarlWatson,
    testUserModelGregoryHouse,
    testUserModelSherlockHolmes
]
