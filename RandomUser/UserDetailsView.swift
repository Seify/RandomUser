import SwiftUI

struct UserDetailsView: View {
    let user: RandomUserModel

    var imageURL: URL? { URL(string: user.largePicture) }
    var name: String {
        "\(user.title) \(user.firstName) \(user.lastName)"
    }
    var email: String { user.email }
    var phone: String { user.phone }
    var gender: String { user.gender }
    var location: String { "\(user.streetNumber), \(user.streetName), \(user.city), \(user.state)"}
    var registered: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = formatter.date(from: user.registered) else { return "" }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: imageURL) { phase in
                let image = phase.image ?? Image(systemName: "person.circle")

                return image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)

            }

            Text(name)
                .font(.title)

            Form {
                LabeledContent("Email", value: email)
                LabeledContent("Phone", value: phone)
                LabeledContent("Gender", value: gender)
                LabeledContent("Location", value: location)
                LabeledContent("Registered", value: registered)
            }
                .scrollContentBackground(.hidden)
        }
        .navigationTitle("User")
    }
}

//#Preview {
//    UserDetailsView()
//}
