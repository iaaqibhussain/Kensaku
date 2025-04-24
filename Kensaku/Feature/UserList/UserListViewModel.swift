//
//  UserListViewModel.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

final class UserListViewModelImpl: ObservableObject {
    @Published private(set) var users: [UserViewData] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    var navigationTitle: String {
        "Users"
    }
    
    private let repository: UserListRepository
    private let mapper: UserViewDataMapper
    
    
    init(
        repository: UserListRepository = UserListRepositoryImpl(),
        mapper: UserViewDataMapper = UserViewDataMapperImpl()
    ) {
        self.repository = repository
        self.mapper = mapper
    }
    
    func fetchUsers() async {
        await MainActor.run { self.isLoading = true }
        do {
            let fetchedUsers = try await repository.fetchUsers()
            let usersViewData = mapper.map(fetchedUsers)
            await MainActor.run {
                self.users = usersViewData
                self.isLoading = false
            }
        } catch let error {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
