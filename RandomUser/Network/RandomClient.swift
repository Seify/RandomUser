import Foundation

enum RandomClientError: Error {
    case failedToCreateURL
    case failedResponse
    case failedResponseStatusCode(Int)
}

final class RandomClient: ObservableObject {

    private let decoder: RandomJsonDecoder

    init(decoder: RandomJsonDecoder) {
        self.decoder = decoder
    }

    private func getObjectFrom<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw RandomClientError.failedResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw RandomClientError.failedResponseStatusCode(httpResponse.statusCode)
        }

        let object: T = try decoder.decode(data: data)

        return object
    }

    func getUsers(_ limit: Int = 40) async throws -> RandomUsers {
        
        guard let url = URL(string: Endpoints.users(limit).path) else {
            throw RandomClientError.failedToCreateURL
        }

        let users: RandomUsers = try await getObjectFrom(url: url)
        return users
    }

}
