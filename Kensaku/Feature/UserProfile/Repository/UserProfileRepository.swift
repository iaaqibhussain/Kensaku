//
//  UserProfileRepository.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

protocol UserProfileRepository {
    func fetchProfile(for username: String) async throws -> UserProfile
    func fetchRepositories(for username: String) async throws -> [UserRepo]
}

final class UserProfileRepositoryImpl: UserProfileRepository {
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchProfile(for username: String) async throws -> UserProfile {
        let request = UserProfileRequest(username: username)
        return try await networkService.execute(request)
    }
    
    func fetchRepositories(for username: String) async throws -> [UserRepo] {
        let request = UserRepoRequest(username: username)
        return try await networkService.execute(request)
    }
}

