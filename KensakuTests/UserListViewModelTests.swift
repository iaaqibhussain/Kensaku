//
//  UserListViewModelTests.swift
//  KensakuTests
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation
import Testing
@testable import Kensaku

struct UserListViewModelTests {

    @Test
    func fetchUsersSuccessfulResponseSetsUsers() async throws {
        // Given
        let repository = UserListRepositoryMock()
        repository.usersToReturn = [
            User(id: 1, login: "octocat", avatarUrl: "https://example.com/avatar.png")
        ]
        
        let expectedViewData = [
            UserViewData(
                id: 1,
                username: "octocat",
                avatarUrl: URL(string: "https://example.com/avatar.png")
            )
        ]
        
        let viewModel = UserListViewModelImpl(repository: repository)

        // When
        await viewModel.fetchUsers()

        // Then
        #expect(viewModel.users == expectedViewData)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func fetchUsersFailsSetsErrorMessage() async throws {
        // Given
        let repository = UserListRepositoryMock()
        repository.shouldThrowError = true
        repository.errorToThrow = NetworkRequestError.statusCode(500)
        
        let viewModel = UserListViewModelImpl(repository: repository)
        
        // When
        await viewModel.fetchUsers()

        // Then
        #expect(viewModel.users.isEmpty)  // No users should be present
        #expect(viewModel.errorMessage == NetworkRequestError.statusCode(500).localizedDescription)
        #expect(viewModel.isLoading == false)
    }
}
