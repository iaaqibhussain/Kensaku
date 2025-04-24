//
//  UserProfileViewModel.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation
import SwiftUI
protocol UserProfileViewModel {
    var profileViewData: UserProfileViewData? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchProfile(_ username: String) async
}

final class UserProfileViewModelImpl: UserProfileViewModel, ObservableObject {
    private(set) var profileViewData: UserProfileViewData?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: UserProfileRepository
    private let mapper: UserProfileViewDataMapper
    
    init(
        repository: UserProfileRepository = UserProfileRepositoryImpl(),
        mapper: UserProfileViewDataMapper = UserProfileViewDataMapperImpl()
    ) {
        self.repository = repository
        self.mapper = mapper
    }
    
    func fetchProfile(_ username: String) async {
        await MainActor.run { self.isLoading = true }
        do {
            let profile = try await repository.fetchProfile(for: username)
            let repositories = try await repository.fetchRepositories(for: username)
            
            let profileViewData = mapper.map(
                profile,
                repositories
            )
           
            await MainActor.run {
                self.profileViewData = profileViewData
                isLoading = false
            }
        } catch let error {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
