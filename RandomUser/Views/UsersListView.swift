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

    @State private var filteredUsers: [RandomUserModel] = []

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
                    .onAppear {
                        Task {
                            await loadUsersIfNeeded(lastAppearedUser: user)
                        }
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
        .onChange(of: searchText) {
            // TODO: add debounce
            // https://tarkalabs.com/blogs/debounce-in-swift/
            updateFilteredUsers()
        }
        .onAppear() {
            updateFilteredUsers()
            Task {
                if users.count == 0 {
                    await loadUsers()
                }
            }
        }
    }

    private func loadUsersIfNeeded(lastAppearedUser: RandomUserModel) async {
        guard searchText.isEmpty, selectedTokens.isEmpty else {
            return
        }

        if let lastUser = users.last, lastUser.uuid == lastAppearedUser.uuid {
            await loadUsers()
        }
    }

    private func loadUsers() async {
        do {
            let users = try await RandomClient(decoder: RandomJsonDecoder()).getUsers()
            for user in users.results {
                let model = RandomUserModel(user: user)
                modelContext.insert(model)
            }
            try modelContext.save()
            updateFilteredUsers()
        } catch {
            print(error)
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
                updateFilteredUsers()
            }
        }
    }

    private func updateFilteredUsers() {
        filteredUsers = users.filter { user in
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
}

//#Preview {
//    UsersListView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
