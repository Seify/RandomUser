import Foundation
import SwiftData

@Model
class RandomUserModel {

    @Attribute(.unique) var uuid: String

    var title: String
    var firstName: String
    var lastName: String

    var gender: String

    var streetNumber: Int
    var streetName: String
    var city: String
    var state: String

    var email: String

    var phone: String

    var registered: String

    var largePicture: String
    var mediumPicture: String
    var thumbnail: String

    init(
        title: String,
        firstName: String,
        lastName: String,
        gender: String,
        streetNumber: Int,
        streetName: String,
        city: String,
        state: String,
        email: String,
        phone: String,
        registered: String,
        largePicture: String,
        mediumPicture: String,
        thumbnail: String,
        uuid: String
    ) {
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.streetNumber = streetNumber
        self.streetName = streetName
        self.city = city
        self.state = state
        self.email = email
        self.phone = phone
        self.registered = registered
        self.largePicture = largePicture
        self.mediumPicture = mediumPicture
        self.thumbnail = thumbnail
        self.uuid = uuid
    }
}
