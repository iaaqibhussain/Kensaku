//
//  UserProfileViewModelTests.swift
//  KensakuTests
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation
import Testing
@testable import Kensaku

struct UserProfileViewModelTests {
    
    @Test
    func fetchProfile_success_setsProfileViewData() async throws {
        // Given
        let repository = UserProfileRepositoryMock()

        repository.profileToReturn = UserProfile(
            id: 1,
            login: "octocat",
            avatarUrl: "https://example.com/avatar.png",
            name: "The Octocat",
            followers: 1000,
            following: 50
        )

        repository.reposToReturn = [
            UserRepo(
                id: 1,
                name: "TestRepo",
                description: "A test repo",
                stargazersCount: 200,
                language: "Swift",
                htmlUrl: "https://github.com/octocat/TestRepo",
                fork: false
            )
        ]

        let expectedViewData = UserProfileViewData(
            id: 1,
            atUsername: "@octocat",
            displayName: "The Octocat",
            avatarUrl: URL(string: "https://example.com/avatar.png"),
            followers: "1000",
            following: "50",
            repositories: [
                UserRepoViewData(
                    id: 1,
                    name: "TestRepo",
                    description: "A test repo",
                    stars: "200",
                    language: "Swift",
                    url: URL(string: "https://github.com/octocat/TestRepo"),
                    fork: false
                )
            ]
        )

        // When
        let viewModel = UserProfileViewModelImpl(repository: repository)
        await viewModel.fetchProfile("octocat")

        // Then
        #expect(viewModel.profileViewData == expectedViewData)
        
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func fetchProfile_failure_setsErrorMessage() async throws {
        // Given
        let repository = UserProfileRepositoryMock()
        repository.shouldThrowError = true
        repository.errorToThrow = NetworkRequestError.statusCode(404)
        
        let viewModel = UserProfileViewModelImpl(repository: repository)

        // When
        await viewModel.fetchProfile("ghost")

        // Then
        #expect(viewModel.profileViewData == nil)
        #expect(viewModel.errorMessage == NetworkRequestError.statusCode(404).localizedDescription)
        #expect(viewModel.isLoading == false)
    }
}
