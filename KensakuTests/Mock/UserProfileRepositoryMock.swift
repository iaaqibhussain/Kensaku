//
//  UserProfileRepositoryMock.swift
//  KensakuTests
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation
@testable import Kensaku

final class UserProfileRepositoryMock: UserProfileRepository {
    var profileToReturn: UserProfile?
    var reposToReturn: [UserRepo] = []
    var shouldThrowError = false
    var errorToThrow: Error = NetworkRequestError.requestFailed(underlying: NSError(domain: "Test", code: 0))

    func fetchProfile(for username: String) async throws -> UserProfile {
        if shouldThrowError { throw errorToThrow }
        return profileToReturn!
    }

    func fetchRepositories(for username: String) async throws -> [UserRepo] {
        if shouldThrowError { throw errorToThrow }
        return reposToReturn
    }
}
