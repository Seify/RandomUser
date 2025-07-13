import Foundation

extension RandomUserModel {
    convenience init(user: RandomUser) {
        self.init(
            title: user.name.title,
            firstName: user.name.first,
            lastName: user.name.last,
            gender: user.gender,
            streetNumber: user.location.street.number,
            streetName: user.location.street.name,
            city: user.location.city,
            state: user.location.state,
            email: user.email,
            phone: user.phone,
            registered: user.registered.date,
            largePicture: user.picture.large,
            mediumPicture: user.picture.medium,
            thumbnail: user.picture.thumbnail,
            uuid: user.login.uuid,
            isDeleted: false
        )
    }
}
