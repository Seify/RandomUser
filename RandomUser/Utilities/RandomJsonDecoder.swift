import Foundation

final class RandomJsonDecoder: ObservableObject {
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
