import Foundation

protocol RandomJsonDecoderProtocol {
    func decode<T: Decodable>(data: Data) throws -> T
}

struct RandomJsonDecoder: RandomJsonDecoderProtocol {
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
