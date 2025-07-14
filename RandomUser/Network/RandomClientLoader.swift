import Foundation

protocol RandomClientLoaderProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)

}

class RandomClientLoader: RandomClientLoaderProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(from: url)
    }
}
