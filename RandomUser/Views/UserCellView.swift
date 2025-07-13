import SwiftUI

struct UserCellView: View {

    let user: RandomUserModel

    var imageURL: URL? { URL(string: user.thumbnail) }
    var name: String {
        "\(user.title) \(user.firstName) \(user.lastName)"
    }
    var email: String { user.email }
    var phone: String { user.phone }

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: imageURL) { phase in
                let image = phase.image ?? Image(systemName: "person.circle")

                return image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)

            }

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(email)
                Text(phone)
            }
        }
    }
}

//#Preview {
//    UserCellView()
//}
