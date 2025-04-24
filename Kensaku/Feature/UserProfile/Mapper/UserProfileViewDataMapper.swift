//
//  UserProfileViewDataMapper.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

protocol UserProfileViewDataMapper {
    func map(
        _ profile: UserProfile,
        _ repositories: [UserRepo]
    ) -> UserProfileViewData
}

final class UserProfileViewDataMapperImpl: UserProfileViewDataMapper {
    func map(
        _ profile: UserProfile,
        _ repositories: [UserRepo]
    ) -> UserProfileViewData {
        let nonForkedRepositoriesViewData = repositories.filter { !$0.fork }.map { repository in
                UserRepoViewData(
                    id: repository.id,
                    name: repository.name,
                    description: repository.description ?? "",
                    stars: String(repository.stargazersCount),
                    language: repository.language ?? "",
                    url: URL(string: repository.htmlUrl),
                    fork: repository.fork
                )
            }
    
        return UserProfileViewData(
            id: profile.id,
            atUsername: "@\(profile.login)",
            displayName: profile.name,
            avatarUrl: URL(string: profile.avatarUrl),
            followers: String(profile.followers),
            following: String(profile.following),
            repositories: nonForkedRepositoriesViewData
        )
    }
}
