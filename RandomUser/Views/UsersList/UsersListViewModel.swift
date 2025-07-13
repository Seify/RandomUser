import Foundation

@Observable
class UsersListViewModel {
    var searchText: String = ""
    var selectedTokens: [UserSearchToken] = []
    var suggestedTokens = UserSearchToken.allCases

    private(set) var filteredUsers: [RandomUserModel] = []

    var isNotSearching: Bool {
        searchText.isEmpty && selectedTokens.isEmpty
    }

    func updateFilteredUsers(from users: [RandomUserModel]) {

        guard !searchText.isEmpty else {
            filteredUsers = users
            return
        }

        guard let token = selectedTokens.first else {
            filteredUsers = users.filter({ user in
                isUserMatchAnyToken(user)
            })
            return
        }

        filteredUsers = users.filter { user in
            isUser(user, matchToken: token)
        }
    }

    private func isUser(_ user: RandomUserModel, matchToken token: UserSearchToken) -> Bool {

        switch token {
            case .name:
                user.firstName.localizedStandardContains(searchText)
            case .surname:
                user.lastName.localizedStandardContains(searchText)
            case .email:
                user.email.localizedStandardContains(searchText)
        }
    }

    private func isUserMatchAnyToken(_ user: RandomUserModel) -> Bool {

        for token in UserSearchToken.allCases {
            if isUser(user, matchToken: token) {
                return true
            }
        }

        return false
    }
}

