import SwiftUI
import SwiftData

struct UsersListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<RandomUserModel> { user in
        user.isDeleted == false
    }) private var users: [RandomUserModel]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        UserCellView(user: user)
                    }
                }
                .onDelete(perform: deleteUsers)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Random Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
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

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteUsers(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                users[index].isDeleted = true
            }
        }
    }
}

#Preview {
    UsersListView()
        .modelContainer(for: Item.self, inMemory: true)
}
