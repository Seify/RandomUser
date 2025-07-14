import Foundation

enum RandomClientError: Error {
    case failedToCreateURL
    case failedResponse
    case failedResponseStatusCode(Int)
}

final class RandomClient: ObservableObject {

    private let decoder: RandomJsonDecoder
    private let loader: RandomClientLoaderProtocol

    init(decoder: RandomJsonDecoder, loader: RandomClientLoaderProtocol) {
        self.decoder = decoder
        self.loader = loader
    }

    private func getObjectFrom<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await loader.data(from: url)

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
