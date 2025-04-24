//
//  UserListRepository.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

protocol UserListRepository {
    func fetchUsers() async throws -> [User]
}

final class UserListRepositoryImpl: UserListRepository {
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchUsers() async throws -> [User] {
        try await networkService.execute(UserListRequest())
    }
}
