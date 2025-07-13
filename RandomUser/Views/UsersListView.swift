import SwiftUI
import SwiftData

struct UsersListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<RandomUserModel> { user in
            user.isDeleted == false
        },
        sort: \RandomUserModel.timestamp
    ) private var users: [RandomUserModel]

    private var filteredUsers: [RandomUserModel] {
        users.filter { user in
            if searchText.isEmpty {
                return true
            }

            guard let token = selectedTokens.first else { return true }

            return switch token {
                case .name:
                    user.firstName.localizedStandardContains(searchText)
                case .surname:
                    user.lastName.localizedStandardContains(searchText)
                case .email:
                    user.email.localizedStandardContains(searchText)
            }
        }
    }

    @State private var searchText: String = ""
    @State var selectedTokens = [UserSearchToken]()
    @State var suggestedTokens = UserSearchToken.allCases

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredUsers) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        UserCellView(user: user)
                    }
                }
                .onDelete(perform: deleteUsers)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Users")
        }
        .searchable(
            text: $searchText,
            tokens: $selectedTokens,
            suggestedTokens: $suggestedTokens,
            token: { Text($0.rawValue) }
        )
        .onSubmit(of: .search) {
            print("Submit!")
        }
        .task {
            do {
                let users = try await RandomClient(decoder: RandomJsonDecoder()).getUsers()
                for user in users.results {
                    let model = RandomUserModel(user: user)
                    modelContext.insert(model)
                }
            } catch {
                print(error)
            }
        }
    }

    private func deleteUsers(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let user = filteredUsers[index]
                let userModel = users.first(where: { $0.uuid == user.uuid })
                userModel?.isDeleted = true
                do {
                    try modelContext.save()
                } catch {
                    print("failed to save model")
                }
            }
        }
    }
}

//#Preview {
//    UsersListView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
