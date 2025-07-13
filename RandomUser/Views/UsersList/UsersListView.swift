import SwiftUI
import SwiftData

struct UsersListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<RandomUserModel> { user in
            user.isDeleted == false
        },
        sort: \.timestamp
    ) private var users: [RandomUserModel]

    @State private var viewModel = UsersListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredUsers) { user in
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
            text: $viewModel.searchText,
            tokens: $viewModel.selectedTokens,
            suggestedTokens: $viewModel.suggestedTokens,
            token: { Text($0.rawValue) }
        )
        .onChange(of: viewModel.searchText) {
            // TODO: add debounce
            // https://tarkalabs.com/blogs/debounce-in-swift/
            viewModel.updateFilteredUsers(from: users)
        }
        .onAppear() {
            viewModel.updateFilteredUsers(from: users)
            Task {
                if users.count == 0 {
                    await loadUsers()
                }
            }
        }
    }

    private func loadUsersIfNeeded(lastAppearedUser: RandomUserModel) async {
        guard viewModel.isNotSearching else {
            return
        }

        if let lastUser = users.last, lastUser.uuid == lastAppearedUser.uuid {
            await loadUsers()
        }
    }

    private func loadUsers() async {
        do {
            let newUsers = try await RandomClient(decoder: RandomJsonDecoder()).getUsers()
            for user in newUsers.results {
                let model = RandomUserModel(user: user)
                modelContext.insert(model)
            }
            try modelContext.save()
            viewModel.updateFilteredUsers(from: users)
        } catch {
            print(error)
        }
    }

    private func deleteUsers(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                deleteUser(at: index)
            }

            do {
                try modelContext.save()
            } catch {
                print(error)
            }
            
            viewModel.updateFilteredUsers(from: users)
        }
    }

    private func deleteUser(at index: IndexSet.Element) {
        let user = viewModel.filteredUsers[index]
        let userModel = users.first(where: { $0.uuid == user.uuid })
        userModel?.isDeleted = true
    }
}

//#Preview {
//    UsersListView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
