enum UserSearchToken: String, Hashable, CaseIterable, Identifiable {
    case name = "Name"
    case surname = "Surname"
    case email = "Email"
    var id: String { rawValue }
}
