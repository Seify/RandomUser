import Foundation

protocol RandomClientProtocol {
    func getUsers(_ limit: Int) async throws -> [RandomUser]
}

enum RandomClientError: Error {
    case failedToCreateURL
    case failedResponse
    case failedResponseStatusCode(Int)
}

final class RandomClient: RandomClientProtocol {
    func getUsers(_ limit: Int = 40) async throws -> [RandomUser] {
        guard let url = URL(string: Endpoints.users(limit).path) else {
            throw RandomClientError.failedToCreateURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw RandomClientError.failedResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw RandomClientError.failedResponseStatusCode(httpResponse.statusCode)
        }

        let users = try JSONDecoder().decode(RandomUsers.self, from: data)
        return users.results
    }

}
