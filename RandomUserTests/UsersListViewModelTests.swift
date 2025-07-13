import XCTest
@testable import RandomUser

final class UsersListViewModelTests: XCTestCase {

    let users = testUserModels
    var sut: UsersListViewModel!

    override func setUp() {
        sut = UsersListViewModel()
    }

    func testSearchByEmail() throws {
        //given
        sut.selectedTokens = [.email]
        sut.searchText = "Watson@"

        //when
        sut.updateFilteredUsers(from: users)

        //then
        XCTAssertEqual(sut.filteredUsers.count, 2)
        XCTAssert(sut.filteredUsers.contains(testUserModelKarlWatson))
        XCTAssert(sut.filteredUsers.contains(testUserModelEmilWatson))
    }

    func testSearchByName() throws {
        //given
        sut.selectedTokens = [.name]
        sut.searchText = "rl"

        //when
        sut.updateFilteredUsers(from: users)

        //then
        XCTAssertEqual(sut.filteredUsers.count, 2)
        XCTAssert(sut.filteredUsers.contains(testUserModelSherlockHolmes))
        XCTAssert(sut.filteredUsers.contains(testUserModelKarlWatson))
    }

    func testSearchBySurname() throws {
        //given
        sut.selectedTokens = [.surname]
        sut.searchText = "Watson"

        //when
        sut.updateFilteredUsers(from: users)

        //then
        XCTAssertEqual(sut.filteredUsers.count, 3)
        XCTAssert(sut.filteredUsers.contains(testUserModelEmilWatson))
        XCTAssert(sut.filteredUsers.contains(testUserModelEmmaWatson))
        XCTAssert(sut.filteredUsers.contains(testUserModelKarlWatson))
    }

    func testSearchNameSurnameEmail() {
        //given
        sut.selectedTokens = []
        sut.searchText = "holmes"

        //when
        sut.updateFilteredUsers(from: users)

        //then
        XCTAssertEqual(sut.filteredUsers.count, 2)
        XCTAssert(sut.filteredUsers.contains(testUserModelSherlockHolmes))
        XCTAssert(sut.filteredUsers.contains(testUserModelGregoryHouse))

    }
}
