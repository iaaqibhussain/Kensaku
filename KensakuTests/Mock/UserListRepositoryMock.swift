//
//  UserListRepositoryMock.swift
//  KensakuTests
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation
@testable import Kensaku

final class UserListRepositoryMock: UserListRepository {
    var usersToReturn: [User] = []
    var shouldThrowError: Bool = false
    var errorToThrow: Error = NetworkRequestError.requestFailed(underlying: NSError(domain: "Test", code: -1))

    func fetchUsers() async throws -> [User] {
        if shouldThrowError {
            throw errorToThrow
        }
        return usersToReturn
    }
}
