import XCTest
@testable import RandomUser

final class RandomJsonDecoderTests: XCTestCase {

    let sut = RandomJsonDecoder()
    let correctData: Data! = TestJson.data(using: .utf8)
    let incorrectData: Data! = "Wrong JSON".data(using: .utf8)

    func testDecodeCorrectUsersCount() throws {
        //given
        let data = correctData!

        //when
        let decodedJson: RandomUsers = try sut.decode(data: data)

        // then
        XCTAssert(decodedJson.results.count == 5)
    }

    func testDecodeCorrectUser() throws {
        //given
        let data = correctData!

        //when
        let decodedJson: RandomUsers = try sut.decode(data: data)
        let firstUser = decodedJson.results.first!

        // then
        XCTAssertEqual(firstUser.login.uuid, "9c784de3-90da-479a-a92c-0e9485e0abb4")
        XCTAssertEqual(firstUser.gender, "female")
        XCTAssertEqual(firstUser.name.title, "Mrs")
        XCTAssertEqual(firstUser.name.first, "Lisa")
        XCTAssertEqual(firstUser.name.last, "Romero")
        XCTAssertEqual(firstUser.location.street.number, 2756)
        XCTAssertEqual(firstUser.location.street.name, "Thornridge Cir")
        XCTAssertEqual(firstUser.location.city, "Tweed")
        XCTAssertEqual(firstUser.location.state, "New South Wales")
        XCTAssertEqual(firstUser.email, "lisa.romero@example.com")
        XCTAssertEqual(firstUser.phone, "03-9066-7348")
        XCTAssertEqual(firstUser.picture.large, "https://randomuser.me/api/portraits/women/52.jpg")
        XCTAssertEqual(firstUser.picture.medium, "https://randomuser.me/api/portraits/med/women/52.jpg")
        XCTAssertEqual(firstUser.picture.thumbnail, "https://randomuser.me/api/portraits/thumb/women/52.jpg")
        XCTAssertEqual(firstUser.registered.date, "2007-08-05T00:09:45.367Z")
    }

    func testThrowsWhenIncorrectJson() throws {
        //given
        let data = incorrectData!
        var didThrow: Bool = false

        //when
        do {
            let _: RandomUsers = try sut.decode(data: data)
        } catch {
            didThrow = true
        }

        // then
        XCTAssert(didThrow)
    }

    func testThrowsWhenIncorrectObjectType() throws {
        //given
        let data = correctData!
        var didThrow: Bool = false

        //when
        do {
            let _: RandomUserName = try sut.decode(data: data)
        } catch {
            didThrow = true
        }

        // then
        XCTAssert(didThrow)
    }

}
