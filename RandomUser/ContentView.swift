//
//  ContentView.swift
//  RandomUser
//
//  Created by Roman Smirnov on 11.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [RandomUserModel]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        Text("\(user.email)")
                    } label: {
                        Text("\(user.title) \(user.firstName) \(user.lastName)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
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

                print("users = \(users)")
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(users[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
