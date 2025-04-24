//
//  KensakuTests.swift
//  KensakuTests
//
//  Created by Syed Muhammad Aaqib Hussain on 23.04.25.
//

import Foundation
import Testing
@testable import Kensaku

struct UserProfileViewDataMapperTests {

    @Test
    func mapUserProfileAndUserRepoToUserProfileViewData() {
        // Given
        let profile = UserProfile(
            id: 1,
            login: "octocat",
            avatarUrl: "https://example.com/avatar.png",
            name: "The Octocat",
            followers: 1000,
            following: 50
        )
        
        let repositories = [
            UserRepo(
                id: 1,
                name: "SwiftRepo",
                description: "A Swift repository",
                stargazersCount: 150,
                language: "Swift",
                htmlUrl: "https://github.com/octocat/SwiftRepo",
                fork: false
            ),
            UserRepo(
                id: 2,
                name: "ForkedRepo",
                description: "A forked repository",
                stargazersCount: 80,
                language: "Objective-C",
                htmlUrl: "https://github.com/octocat/ForkedRepo",
                fork: true
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
                    name: "SwiftRepo",
                    description: "A Swift repository",
                    stars: "150",
                    language: "Swift",
                    url: URL(string: "https://github.com/octocat/SwiftRepo"),
                    fork: false
                )
            ]
        )
        
        let mapper = UserProfileViewDataMapperImpl()

        // When
        let result = mapper.map(profile, repositories)

        // Then
        #expect(result == expectedViewData)

    }
}
