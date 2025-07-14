import XCTest
@testable import RandomUser

final class RandomClientTests: XCTestCase {

    let decoder = RandomJsonDecoder()
    var sut: RandomClient!
    let url: URL! = URL(string: "https://google.com")

    func httpUrlResponse(statusCode: Int) -> URLResponse {
        HTTPURLResponse(
            url: url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    func testLoadAndDecode() async throws {
        //given
        let data = TestJson.data(using: .utf8)!
        let response = httpUrlResponse(statusCode: 200)
        let mockLoader = RandomClientLoaderMock(
            data: data,
            response: response
        )
        let decoder = RandomJsonDecoder()
        sut = RandomClient(decoder: decoder, loader: mockLoader)
        var loadedUsers: RandomUsers!
        let expectedResult: RandomUsers = try decoder.decode(data: data)

        //when
        do {
            loadedUsers = try await sut.getUsers()
        } catch {
            XCTFail()
        }

        // then
        XCTAssertEqual(loadedUsers, expectedResult)
    }

    func testThrowOnNonHttpResponse() async throws {
        //given
        let data = Data()
        let mockLoader = RandomClientLoaderMock(data: data, response: URLResponse())
        sut = RandomClient(decoder: RandomJsonDecoder(), loader: mockLoader)
        var didThrowFailedResponse: Bool = false

        //when
        do {
            let _ = try await sut.getUsers()
        } catch {
            switch error {
                case RandomClientError.failedResponse:
                    didThrowFailedResponse = true
                default:
                    break
            }
        }

        // then
        XCTAssert(didThrowFailedResponse)
    }

    func testThrowWhenStatusCodeIsNot200() async throws {
        //given
        let statusCode = 500
        let response = httpUrlResponse(statusCode: statusCode)
        let data = Data()
        let mockLoader = RandomClientLoaderMock(data: data, response: response)
        sut = RandomClient(decoder: RandomJsonDecoder(), loader: mockLoader)
        var didThrowFailedResponseStatusCode: Bool = false

        //when
        do {
            let _ = try await sut.getUsers()
        } catch {
            switch error {
                case RandomClientError.failedResponseStatusCode(let responseStatusCode):
                    didThrowFailedResponseStatusCode = responseStatusCode == statusCode
                default:
                    break
            }
        }

        // then
        XCTAssert(didThrowFailedResponseStatusCode)
    }
}
