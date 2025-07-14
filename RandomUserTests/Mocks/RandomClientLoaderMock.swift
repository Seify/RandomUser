import XCTest
@testable import RandomUser

class RandomClientLoaderMock: RandomClientLoaderProtocol {

    let data: Data
    let response: URLResponse

    init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        return (data, response)
    }
}
