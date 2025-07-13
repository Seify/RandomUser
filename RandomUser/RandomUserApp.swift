import SwiftUI
import SwiftData

@main
struct RandomUserApp: App {
    var sharedModelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: RandomUserModel.self)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            UsersListView()
                .environmentObject(RandomDateFormatter())
                .environmentObject(RandomClient(decoder: RandomJsonDecoder()))

        }
        .modelContainer(sharedModelContainer)
    }
}
